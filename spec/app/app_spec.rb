require File.expand_path '../../spec_helper.rb', __FILE__

describe "app", :type => :feature  do

  it "should allow accessing the home page" do
    get '/'
    expect(last_response).to be_ok
  end

  it "should display a 'new game' button at the home page" do
    visit '/'
    expect(page.has_button?("Start a New Game")).to be_truthy
  end

  describe "starting a new game", :type => :feature do

    it "should display a fresh chessboard when pressed" do
      visit '/'
      click_button('Start a New Game')
      expect(page.has_table?('chessboard')).to be_truthy
    end

    it "should ask white player for a move" do
      visit '/'
      click_button('Start a New Game')
      expect(page.has_field?('initial_position')).to be_truthy
      expect(page.has_field?('new_position')).to be_truthy
      expect(page.assert_text(:visible, "White Player")).to be_truthy
    end

  end

  describe "making a move" do

    it "should be able to move a white pawn" do
      visit '/new_game'
      fill_in('initial_position', with:"D2")
      fill_in('new_position', with:"D4")
      click_button('Move!')
      expect(page.find_by_id("D4", text:Pawn.new("white").to_s)).to be_truthy
      expect(page.find_by_id("D2", " ")).to be_truthy
    end

    it "should not be able to move a black pawn" do
      visit '/new_game'
      fill_in('initial_position', with:"D7")
      fill_in('new_position', with:"D5")
      click_button('Move!')
      expect(page.find_by_id("D7", text:Pawn.new("black").to_s)).to be_truthy
      expect(page.find_by_id("D5", " ")).to be_truthy
    end

  end

end
