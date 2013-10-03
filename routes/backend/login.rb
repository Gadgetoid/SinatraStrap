class App < Sinatra::Base

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/login' do
    redirect '/secure' if session[:valid]
    erb :login
  end

  post '/login' do
    redirect CONFIG.secure_home if session[:valid]

    email = params[:email]
    pass = params[:pass]

    if user = User.first( :email => email ) and user.password == pass
      session[:valid] = true
      session[:id] = user.id
      redirect CONFIG.secure_home
    else
      erb 'backend/login'.to_sym
    end
  end
end