class User
  include DataMapper::Resource

  def full_name
    return [self.first_name,self.last_name].join(' ')
  end

  def can?( credential )

    self.credentials.include? Credential.first( :title => credential )

  end

  def has_errors
    return self.errors.length > 0
  end

  def get_errors
    errors = self.errors.collect do |error|
      if error.is_a? Array or error.is_a? Hash
        error[0]
      else
        error
      end
    end
  end

  def from_hash( hash )

    begin

      self.email = hash[:email]
      self.password = hash[:pass]
      self.first_name = hash[:first_name]
      self.last_name = hash[:last_name]
      self.enabled = true

      if self.valid?
        self.save!
        return self
      else
        return self
      end

    rescue ArgumentError => @exception

      self.errors.add nil, @exception.message

    rescue DataObjects::IntegrityError => @exception

      self.errors.add nil, @exception.message

    end

    return self

  end

  def password=( password )

    raise ArgumentError, 'Password must be at least ' + CONFIG.pass.length.to_s + ' characters long' if password
    .length < CONFIG.pass.length
    raise ArgumentError, 'Password must contain at least one digit ' unless /\d/.match(password) if CONFIG.pass
    .require_digits
    super

  end

  property :id, Serial

  property :email, String,
           :format => :email_address,
           :unique => :email,
           :required => true
  property :password, BCryptHash,
           :required => true

  property :first_name, String,
           :required => true,
           :length => 2..100

  property :last_name, String,
           :required => true,
           :length => 2..100

  property :enabled, Boolean

  has n, :credentials, :through => Resource

end

class Credential
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :required => true
  property :enabled, Boolean, :default => false

end