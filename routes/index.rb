class App < Sinatra::Base
  get '/' do

    # Set the meta title and description for a page
    meta_title 'Sinatra Strap'
    meta_description 'Get started with Sinatra, DataMapper, ERB and Bootstrap CSS'

    # Include route-specific CSS and JS files
    #js '/js/example.js', '/js/other-example.js'
    #css '/css/example.css'

    erb :index
  end
end