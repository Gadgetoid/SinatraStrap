ROOT = File.expand_path File.dirname(__FILE__)

# Keep your routes in /routes/<routename>.rb
# Keep your views in /views/<viewname>.erb
# Keep data access/processing libs in /libs/<libname>.rb

require './lib/config/default_config.rb'
require './lib/config/configuration.rb'

DEFAULT_CONFIG = Hash.new unless defined? DEFAULT_CONFIG

CONFIG = MyConfig.new( File.join(ROOT,'config.yml'),DEFAULT_CONFIG )

# Include data and libs
Dir.glob(ROOT + '/{data,lib,routes}/{*.rb,*/*.rb}').each { |file| require file }


DataMapper.setup(:default, 'sqlite://' + File.join(ROOT,CONFIG.database))
DataMapper.finalize
DataMapper.auto_migrate! if CONFIG.database_action = 'migrate'
DataMapper.auto_upgrade! if CONFIG.database_action = 'upgrade'
setup_admin_user

class App < Sinatra::Base

  configure do

    set :public_folder, 'public'

    enable :sessions
    set :sessions,
      :secret => CONFIG['secret']

  end

  helpers do
    def secure_page( permissions = nil )
      redirect '/login' unless session[:valid]
      if permissions.is_a?(String)
        redirect '/login' unless @user.can? permissions
      elsif permissions.is_a?(Array)
        permissions.each do |permission|
          redirect '/login' unless @user.can? permission
        end
      end
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