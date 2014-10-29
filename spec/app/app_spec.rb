require File.expand_path '../../spec_helper.rb', __FILE__

describe "app" do

  def app
    Sinatra::Application
  end

  it "should allow accessing the home page" do
    get '/'
    expect(last_response).to be_ok
  end

  describe "Game mechanics" do

    before { get '/new_game' }
    
  end

end
