class App < Sinatra::Base
  get CONFIG.secure_home + '/users' do
    secure_page 'Manage Users'
    erb 'backend/create_user'.to_sym
  end

  post CONFIG.secure_home + '/users' do
    secure_page 'Manage Users'

    @new_user = User.new.from_hash( params ) do
      # Additional stuff to do before save is called
      self.enabled = true
    end

    redirect CONFIG.secure_home + '/users' unless @new_user.has_errors

    erb 'backend/create_user'.to_sym
  end

  post CONFIG.secure_home + '/users/permissions' do
    secure_page 'Manage Users'

  end
end