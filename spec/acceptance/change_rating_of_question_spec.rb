require_relative 'acceptance_helper'

feature 'Change rating of Quesiton', %q{
  In order to rate Questions
  As an authorized User
  I want to be able to change Question's rating
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  before(:each, authorized: :true) { sign_in(user) }
  before { visit root_path }

  scenario 'Authorized user votes for good question', authorized: :true, js: true do
    click_on 'Plus'
    sleep(1)
    within '.rating' do
      expect(page).to have_text '1'
    end
  end

  scenario 'Authorized user votes against bad question', authorized: :true, js: true do
    click_on 'Minus'
    sleep(1)
    within '.rating' do
      expect(page).to have_text '-1'
    end
  end

  scenario "Unauthorized user can't vote", js: true do
    expect(page).to_not have_link 'Plus'
    expect(page).to_not have_link 'Minus'
  end
end