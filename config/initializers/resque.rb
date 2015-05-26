uri = URI.parse("redis://localhost:6379/")  
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

#with resque-status
Resque::Plugins::Status::Hash.expire_in = (24 * 60 * 60)

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }
