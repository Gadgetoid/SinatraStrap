ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :test)

require './app.rb'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

Dir.glob(ROOT + '/{spec}/{*.rb,*/*.rb}').each { |file| require file }

describe 'The App' do
  include Rack::Test::Methods

  def app
    App
  end

  it "serves index page" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('<!DOCTYPE html>')
  end

end