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
DataMapper.auto_migrate! if CONFIG.database_action == 'migrate'
DataMapper.auto_upgrade! if CONFIG.database_action == 'upgrade'
setup_admin_user

class App < Sinatra::Base

  attr_reader :meta_title, :meta_description

  configure do

    set :public_folder, 'public'

    enable :sessions
    set :sessions,
    :secret => CONFIG['secret']

  end

  helpers do
    def meta_title( value = nil )
      @meta_title = value unless value.nil?
      return @meta_title
    end

    def meta_description( value = nil )
      @meta_description = value unless value.nil?
      return @meta_description
    end

    def css( *args )
      @includes = {:css=>[],:js=>[]} if @includes.nil?
      args.each do |file|
        @includes[:css].push file
      end
      return @includes[:css]
    end

    def js( *args )
      @includes = {:css=>[],:js=>[]} if @includes.nil?
      args.each do |file|
        @includes[:js].push file
      end
      return @includes[:js]
    end

    def secure_page( *args )
      redirect '/login' unless session[:valid]
      if args.length == 1 and args[0].is_a?(String)
        redirect '/login' unless @user.can? args[0]
      elsif args.length == 1 and args[0].respond_to?(:each)
        args[0].each do |permission|
          redirect '/login' unless @user.can? permission
        end
      elsif args.length > 0
        args.each do |permission|
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

  not_found do
    status 404
    @page_title = '404'
    erb :notfound# , :layout => :no_nav_layout
  end

  set :views, File.join(ROOT,'views')
end