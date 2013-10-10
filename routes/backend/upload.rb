class Views

  def method_missing method_name

    return Views.new( File.join( @method_name , method_name.to_s ) ) unless @method_name.nil?

    return Views.new( method_name.to_s ) if @method_name.nil?

  end

  def initialize( method_name = nil )

    @method_name = method_name.to_s unless method_name.nil?

  end

  def to_sym
    return @method_name.to_sym
  end

end

class App < Sinatra::Base
  get CONFIG.secure_home + '/uploads' do
    secure_page 'Can Upload'
    erb 'backend/uploads'.to_sym
  end

  post CONFIG.secure_home + '/uploads' do
    secure_page 'Can Upload'
    erb 'backend/uploads'.to_sym
  end
end