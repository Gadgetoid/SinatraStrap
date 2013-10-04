class User
  include DataMapper::Resource

  def full_name
    return [self.first_name,self.last_name].join(' ')
  end

  def can?( credential )

    self.credentials.include? Credential.first( :title => credential )

  end

  def password=( password )

    #raise ArgumentError, 'Password must be at least ' + CONFIG.pass.length.to_s + ' characters long' if password
    #.length < CONFIG.pass.length
    #raise ArgumentError, 'Password must contain at least one digit ' unless /\d/.match(password) if CONFIG.pass
    #.require_digits

    self.errors.add :password, 'Password must be at least ' + CONFIG.pass.length.to_s + ' characters long' if password.length < CONFIG.pass.length
    self.errors.add :password, 'Password must contain at least one digit ' unless /\d/.match(password) if CONFIG.pass.require_digits

    raise ArgumentError, 'Password failed validation' if self.errors[:password].length > 0

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