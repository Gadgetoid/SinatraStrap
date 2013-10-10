# Sinatra Strap

### Credits

Sinatra Strap is inspired by SinatStrap by Ben Hamment
and influenced by sinatra_strap: https://github.com/kognizant/sinatra_strap

### Features

Sinatra Strap is a structured Sinatra Boilerplate that includes:

 - Bootstrap CSS 3 - from Bootstrap CDN
 - Basic erb boilerplate templates for homepage and login
 - DataMapper/SQLite setup with login


### Getting Started

We've explained some of the sub directories for you with extra README files, browse into them for more information.

To start, you're going to want to run ./configure.rb to set up your application. Then get building your DataMapper
classes!

### Sinatra Helpers

Sinatra lets us specify some basic helpers which you can re-use in your route handlers. We have set up the following
for your convinience:

 - secure_page - redirects the user to /login if they are not logged in, accepts one or more permissions to check
 against and redirects the user if they lack any of them.

 - js(file1,file2,file3,...) - add one or more JS files ( requires support in layout.erb )

 - css(file1,file2,file3,...) - add one or more CSS ( requires support in layout.erb )

 - meta_title - Set the page title ( requires support in layout.erb )

 - meta_description - Set the page description ( requires support in layout.erb )

To make use of js in your layout.erb, you should do this:

    <% js.each do |javascript| %>
    <script type="text/javascript" src="<%= javascript %>"></script>
    <% end %>