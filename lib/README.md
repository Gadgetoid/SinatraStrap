# Sinatra Strap

### Libraries

Here you should place all the common classes for your application which might be shared across multiple routes.

### Configuration

We couldn't find a Configuration system we liked, so we've provided the MyConfig library in /lib/config/configuration
.rb

This also includes a default Configuration in /lib/config/default_config.rb

All config settings are stored in /config.yml and you can edit this file by hand easily.

We have also supplied a setup tool, /configure.rb, which you can run on the command line to interactively set up your
 application.