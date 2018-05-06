require_relative 'acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answers author
  I want to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds file when answers question', js: true do
    fill_in 'answer[body]', :with => 'Test answer body. Much of text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Answer'
    within '.last_answer' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end

  scenario 'User deletes file when answers question'

  scenario "User can't delete not own files"

end