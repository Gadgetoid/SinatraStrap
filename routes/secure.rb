class App < Sinatra::Base
  get '/secure' do
    secure_page
    erb :secure
  end
end