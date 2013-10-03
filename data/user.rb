class User
  include DataMapper::Resource

  def full_name
    return [self.first_name,self.last_name].join(' ')
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
           :unique => true,
           :required => true
  property :password, BCryptHash,
           :required => true

  property :first_name, String,
           :required => true

  property :last_name, String,
           :required => true

  property :enabled, Boolean

  has n, :credentials, :through => Resource

end

class Credential
  include DataMapper::Resource

  property :id, Serial
  property :title, String

end