# Sinatra Strap

### Routes

Routes are part of Sinatra itself. They govern how a requested URL is handled.

### Get Requests

The most common type of route is a get, this corresponds to the HTTP keyword GET and typically handles a normal web
request, such as your / page, or /about page.

For example:

    get '/' do
      erb :index
    end

Will display the contents of views/index.erb as your homepage.

### Post Requests

Post routes are also common and necessary for an interactive web application. You might use a Post route to handle a
form POST.

For example:

    post '/login' do
      login params[:username], params[:password]
    end

### Structure

Your routes are part of your Sinatra app, so they must be wrapped as such. Usually this means surrounding them with:

    class App < Sinatra::Base
    end

This means you can extend your App with helpers and, in fact, use any of the methods available to Sinatra within your
 routes files.

We've provided a standard helper "secure_page" for you in app.rb, it looks like this:

    helpers do
      def secure_page
        redirect '/login' unless session[:valid]
      end
    end

If you want to define a route that's only available to logged-in users, you can do something like this:

    class App < Sinatra::Base
      get '/my-account' do
        secure_page
        erb 'backend/my-account'.to_sym
      end
    end