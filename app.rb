ROOT = File.expand_path File.dirname(__FILE__)

# Keep your routes in /routes/<routename>.rb
# Keep your views in /views/<viewname>.erb
# Keep data access/processing libs in /libs/<libname>.rb

# Include routes and libs
Dir.glob(ROOT + '/{routes,data,lib}/{*/*.rb,*.rb}').each { |file| require file }

DEFAULT_CONFIG = Hash.new unless defined? DEFAULT_CONFIG

CONFIG = MyConfig.new( File.join(ROOT,'config.yml'),DEFAULT_CONFIG )

DataMapper.setup(:default, 'sqlite://' + File.join(ROOT,CONFIG.database))
DataMapper.finalize
DataMapper.auto_upgrade!
setup_admin_user

class App < Sinatra::Base

  configure do

    set :public_folder, 'public'

    enable :sessions
    set :sessions,
      :secret => CONFIG['secret']

  end

  helpers do
    def secure_page
      redirect '/login' unless session[:valid]
    end
  end

  before do

    @body_class = request.path_info.split('/').join(' path-').strip unless request.path_info == '/'
    @body_class = 'home' if request.path_info == '/'

    if session[:valid]
      @user = User.first( :id => session[:id] )
    end

  end

  set :views, File.join(ROOT,'views')
end