configure :development do
  ActiveRecord::Base.establish_connection(
    :adapter  => 'mysql2',
    :host     => 'localhost',
    :username => 'root',
    :password => '',
    :database => 'sparta',
    :encoding => 'utf8'
  )
end

configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end