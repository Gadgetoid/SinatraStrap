ROOT = File.expand_path File.dirname(__FILE__)

# Keep your routes in /routes/<routename>.rb
# Keep your views in /views/<viewname>.erb
# Keep data access/processing libs in /libs/<libname>.rb

# Include routes and libs
Dir.glob(ROOT + '/{routes,data,lib}/*.rb').each { |file| require file }

DataMapper.finalize
DataMapper.auto_upgrade!

class App < Sinatra::Base

  configure do

    enable :sessions
    set :sessions,
      :secret => CONFIG['secret']

  end

  set :views, File.join(ROOT,'views')
end