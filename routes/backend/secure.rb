class App < Sinatra::Base
  get CONFIG.secure_home do
    secure_page
    erb 'backend/secure'.to_sym
  end
end