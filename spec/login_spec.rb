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