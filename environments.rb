require 'yaml'

DB_CONFIGS = YAML.load_file("database.yml")

configure :development do
  ActiveRecord::Base.establish_connection(
    :adapter  => DB_CONFIGS["sparta_dev"]["adapter"],
    :host     => DB_CONFIGS["sparta_dev"]["host"],
    :username => DB_CONFIGS["sparta_dev"]["username"],
    :password => DB_CONFIGS["sparta_dev"]["password"],
    :database => DB_CONFIGS["sparta_dev"]["database"],
    :encoding => DB_CONFIGS["sparta_dev"]["encoding"]
  )
end

configure :production do
  ActiveRecord::Base.establish_connection(
    :adapter  => DB_CONFIGS["sparta_prod"]["adapter"],
    :host     => DB_CONFIGS["sparta_prod"]["host"],
    :username => DB_CONFIGS["sparta_prod"]["username"],
    :password => DB_CONFIGS["sparta_prod"]["password"],
    :database => DB_CONFIGS["sparta_prod"]["database"],
    :encoding => DB_CONFIGS["sparta_prod"]["encoding"]
  )
end