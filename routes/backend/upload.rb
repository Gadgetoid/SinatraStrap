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