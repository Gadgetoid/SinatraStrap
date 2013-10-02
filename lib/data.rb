DataMapper.setup(:default, 'sqlite://' + File.join(ROOT,DB_NAME))

class User
  include DataMapper::Resource

  def full_name
    return [self.first_name,self.last_name].join(' ')
  end

  property :id, Serial
  property :email, String
  property :password, BCryptHash
  property :first_name, String
  property :last_name, String
  property :enabled, Boolean

  has n, :credentials, :through => Resource

end

class Credential
  include DataMapper::Resource

  property :id, Serial
  property :title, String

end

DataMapper.finalize
DataMapper.auto_upgrade!