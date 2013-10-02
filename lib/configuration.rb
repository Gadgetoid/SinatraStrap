# Created this generic config file system because Sinatra::ConfigFile doesn't support defaults

if defined? CONFIG

  p 'Warning! Config Already Defined!'
  p CONFIG

else

  p 'Setting up Config'

  CONFIG_FILE = File.join(ROOT,'config.yml') unless defined? CONFIG_FILE

  if defined? CONFIG_DEFAULTS and CONFIG_DEFAULTS.is_a? String
    CONFIG_DEFAULTS = YAML::load_file(File.join(ROOT,CONFIG_DEFAULTS))
  end

  CONFIG_DEFAULTS = {
      'admin_email' => 'test@example.com',
      'admin_pass'  => 'test',
      'first_name'  => 'Testington',
      'last_name'   => 'Testleroy',
      'database'    => 'data.db',
      'secret'      => SecureRandom.uuid,
      'expiry'      => 2592000,
      'secure_home' => '/secure'
  } unless defined? CONFIG_DEFAULTS and CONFIG_DEFAULTS.is_a? Hash

  settings = YAML::load_file(CONFIG_FILE)
  settings = Hash.new unless settings
  settings = CONFIG_DEFAULTS.merge( settings )
  File.write(CONFIG_FILE, settings.to_yaml)

  CONFIG = YAML::load_file(CONFIG_FILE)

  # Define a singleton method for accessing config values with CONFIG.key
  CONFIG.define_singleton_method(:method_missing) do |name|
    return self[name] if key? name
    self.each { |k,v| return v if k.to_s.to_sym == name }
    super(name)
  end

  p CONFIG

end