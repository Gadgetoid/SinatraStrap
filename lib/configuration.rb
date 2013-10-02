# Created this generic config file system because Sinatra::ConfigFile doesn't support defaults

class MyConfig

  def [](key)
    return @config[key.to_s]
  end

  def initialize( config_file = File.join(ROOT,'config.yml') )

    @defaults = {
        'admin_email' => 'test@example.com',
        'admin_pass'  => 'test',
        'first_name'  => 'Testington',
        'last_name'   => 'Testleroy',
        'database'    => 'data.db',
        'secret'      => SecureRandom.uuid,
        'expiry'      => 2592000,
        'secure_home' => '/secure'
    }

    p 'Setting up Config'

    @config = YAML::load_file(config_file)
    @config = Hash.new unless @config
    @config = @defaults.merge( @config )
    File.write(config_file, @config.to_yaml)

    p @config

    @config.each do |k,v|
      define_singleton_method(k.to_sym) { return @config[k]} unless self.respond_to?(k.to_sym)
    end

  end

end