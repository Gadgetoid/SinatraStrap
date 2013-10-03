class App < Sinatra::Base
  get '/secure' do
    secure_page
    erb 'backend/secure'.to_sym
  end
end