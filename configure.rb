#!/usr/bin/env ruby -wKU

require 'yaml'

settings = [
    :admin => [
        :email => params['email'],
        :pass => params['pass'],
        :first_name => params['first_name'],
        :last_name => params['last_name'],
        :database => params['database'],
        :secret => params['secret'],
        :expiry => params['expiry'],
        :secure_home => params['secure_home']
    ]
]

File.write('test.yml', settings.to_yaml)