# Created this generic config file system because Sinatra::ConfigFile doesn't support defaults
# Usage:
# CONFIG = MyConfig.new( config_file, defaults )
# CONFIG.get_section.get_subsection
# CONFIG['section']['subsection']
class MyConfig

  attr_reader :location, :defaults

  def raw
    return File.read( @location )
  end

  def [](key)
    return @config[key.to_s]
  end

  def initialize( config_file, defaults )

    @location = config_file

    @defaults = defaults

    p 'Setting up Config'

    @config = YAML::load_file(@location)
    @config = Hash.new unless @config
    @config = @defaults.merge( @config )
    File.write(@location, @config.to_yaml)

    p @config

    @config.each do |k,v|
      define_singleton_method(k) do
        return @config[k] unless @config[k].is_a?(Hash)
        return SubConfig.new(@config[k]) if @config[k].is_a?(Hash)
      end
    end

  end

  # Catch erroneous requests for undefined config values
  def method_missing(meth, *args, &block)
     return 'Unknown config value: ' + meth.to_s
  end

end

class SubConfig

  def [](key)
    return @config[key.to_s]
  end

  def initialize( config )
    @config = config

    @config.each do |k,v|
      define_singleton_method(k.to_sym) do
          return @config[k] unless @config[k].is_a?(Hash)
          return SubConfig.new(@config[k]) if @config[k].is_a?(Hash)
      end
    end

  end


end