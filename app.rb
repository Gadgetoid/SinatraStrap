# Keep your routes in /routes/<routename>.rb
# Keep your views in /views/<viewname>.erb
# Keep data access/processing libs in /libs/<libname>.rb

# Include routes and libs
Dir.glob(ROOT + '/{routes,lib}/*.rb').each { |file| require file }

class App < Sinatra::Base
  set :views, settings.root + '/views'
end