require File.expand_path '../../spec_helper.rb', __FILE__

describe "app" do

  it "should allow accessing the home page" do
    get '/'
    expect(last_response).to be_ok
  end

  describe "starting a new game", :type => :feature do

    it "should display a 'new game' button at the home page" do
      visit '/'
      expect(page.has_button?("Start a New Game")).to be_truthy
    end

    it "should display a fresh chessboard when pressed" do
      visit '/'
      click_button('Start a New Game')
      expect(page.has_table?('chessboard')).to be_truthy
      expect(@board).to eq(Board.new)
    end

  end

end
