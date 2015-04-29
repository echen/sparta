require 'impala'
require 'json'
require 'mustache'
require 'mysql2'
require 'sinatra'
require 'sinatra/activerecord'
require 'yaml'

require './environments'
require './parameters'

use Rack::MethodOverride

DB_CONFIGS = YAML.load_file("database.yml")

class Chart < ActiveRecord::Base

  def full_query(params)
    Mustache.render(self.sql_query, params)
  end

  def get_json_data(params)
    db_config = DB_CONFIGS[self.database]

    if db_config["adapter"] == "mysql2"
      mysql_client = Mysql2::Client.new(
        :host => db_config["host"],
        :username => db_config["username"],
        :password => db_config["password"],
        :database => db_config["database"],
        :port => db_config["port"],
      )

      return mysql_client.query(self.full_query(params)).to_a.to_json
    elsif db_config["adapter"] == "impala"
      data = Impala.connect(db_config["host"], db_config["port"], {:user => db_config["username"]}) do |conn|
        conn.query(self.full_query(params))
      end

      return data.to_json
    end
  end

  def control_params
    tokens = Mustache::Template.new(self.sql_query).tokens
    tokens.find_all { |token| token.is_a?(Array) && token[0] == :mustache }.map{|token| token[2][2]}.flatten
  end

end

get '/' do
  redirect "/charts"
end

get '/charts' do
  @charts = Chart.all

  erb :"charts/index"
end

get '/charts/new' do
  @chart = Chart.new

  erb :"charts/new"
end

get '/charts/:id' do
  @chart = Chart.find(params[:id])

  needed_params = @chart.control_params
  param_values = Parameters.defaults.update(params)
  @control_params = Parameters.values.keep_if { |param| needed_params.include?(param["name"]) }.
    map { |param| param.update({"value" => param_values[param["name"]]}) }
  @has_data_error = false
  @data_error_message = ""
  @data = []
  begin
    @data = @chart.get_json_data(Parameters.defaults.update(params))
  rescue Exception => e
    @data_error = true
    @data_error_message = e.message
  end

  erb :"charts/show"
end

post '/charts' do
  @chart =
    if params[:chart][:id].empty? || params[:chart][:id].to_i == 0
      Chart.new(params[:chart])
    else
      Chart.find(params[:chart][:id])
    end
  @chart.update(params[:chart])

  if @chart.save
    redirect "charts/#{@chart.id}"
  else
    erb :"chart/new"
  end
end

put '/charts/:id/copy' do
  orig_chart = Chart.find(params[:id])
  @chart = Chart.new
  attrs_to_copy = orig_chart.attributes.keys - %w(id created_at creator)
  attrs_to_copy.each do |attr|
    @chart[attr] = orig_chart[attr]
  end
  @chart.title = "Copy of #{orig_chart.title}"

  @chart.save

  redirect "charts/#{@chart.id}"
end

delete '/charts/:id' do
  @chart = Chart.find(params[:id])
  @chart.destroy!

  redirect "/charts"
end
