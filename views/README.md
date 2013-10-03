# Sinatra Strap

### Views

Views are the flesh of your application. They control how it appears to the end user.

You can have as many views as you like, organised into sub directories to keep them tidy.

### layout.erb

layout.erb contains your layout view, this usually establishes the header and footer of your website.

The <%= yield %> statement within layout.erb gives over control to an individual page template.

### Why ERB?

 - The ERB templating system ships with Ruby
 - It's easier to copy and paste Bootstrap CSS examples and widgets into ERB than it is HAML
 - The <% %> and <%= %> syntax should be familiar to many non-Rubyists

### Using Views

To use a view in the /views/ folder you can simply call:

    erb :viewname

To use a view in a subfolder, you must call:

    erb 'subfolder/viewname'.to_sym

