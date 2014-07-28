require 'json'
require 'mysql2'
require 'sinatra'
require 'sinatra/activerecord'
require './environments'

class Chart < ActiveRecord::Base
end

SQL_CLIENT = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => '', :database => 'sparta')

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
  @data = SQL_CLIENT.query(@chart.sql_query).to_a.to_json
  
  erb :"charts/show"
end

# TODO: RESTify
get '/charts/:id/copy' do
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

# TODO: RESTify
get '/charts/:id/delete' do
  @chart = Chart.find(params[:id])
  @chart.destroy!
  
  redirect "/charts"
end

get '/charts/:id' do
  @chart = Chart.find(params[:id])
  @data = SQL_CLIENT.query(@chart.sql_query).to_a.to_json
  
  erb :"charts/show"
end

post '/charts/save' do
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