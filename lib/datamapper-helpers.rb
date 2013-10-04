module DataMapper
  module Resource

  def get_bootstrap3_form( params = nil )
    html = String.new
    properties.each do |property|

      p property

      if property.is_a?(DataMapper::Property::BCryptHash)

        field = '<div class="form-group">'
        field << '<input type="password" id="'
        field << property.name.to_s + '" name="'
        field << property.name.to_s + '" class="form-control" placeholder="'
        field << property.name.to_s.gsub('_',' ').capitalize
        field << '" autofocus value="'
        field << params[property.name] if params.is_a?(Hash) and params.include? property.name
        field << attributes[property.name] if params.nil?
        field << '">'
        field << '<div class="bs-callout bs-callout-danger">' + get_errors(property.name) + '</div>' if has_errors(property.name)
        field << '</div>'

        html << field

      elsif property.is_a?(DataMapper::Property::String)

        field = '<div class="form-group">'
        field << '<input type="text" id="'
        field << property.name.to_s + '" name="'
        field << property.name.to_s + '" class="form-control" placeholder="'
        field << property.name.to_s.gsub('_',' ').capitalize
        field << '" autofocus value="'
        field << params[property.name] if params.is_a?(Hash) and params.include? property.name
        field << attributes[property.name] if params.nil?
        field << '">'
        field << '<div class="bs-callout bs-callout-danger">' + get_errors(property.name) + '</div>' if has_errors(property.name)
        field << '</div>'

        html << field

      end
    end
    return html
  end

    def has_errors( field = nil )

      if field.is_a? Symbol
        error = self.errors[field]
        return true if error.length > 0
      else
        return self.errors.length > 0
      end

      return false

    end

    def get_errors( field = nil )

      if field.is_a? Symbol and field == :generic

        error = self.errors[field]

        return error if error.respond_to? :each
        return [error]

     elsif field.is_a? Symbol

        error = self.errors[field]
        if error.is_a? Array or error.is_a? Hash
          error[0]
        else
          error
        end

      else

        self.errors.collect do |error|
          if error.is_a? Array or error.is_a? Hash
            error[0]
          else
            error
          end
        end

      end
    end

    def from_hash( source_hash, &block )

      begin

        source_hash.each do |k,v|

          p 'Setting ' + k + ' to ' + v
          self.attribute_set(k.to_sym, v)

        end

        instance_eval &block if block_given?

        self.save
      #begin

      rescue DataMapper::SaveFailureError => exception


      rescue NoMethodError,DataObjects::IntegrityError => exception

        self.errors.add :generic, exception.message
        self.errors.add :generic, exception.backtrace[0]

      rescue Exception => exception

        self.errors.add :generic, exception.message
        self.errors.add :generic, exception.backtrace[0]

        raise exception

      rescue


      ensure

        return self

      end

      return self

    end


  end
end