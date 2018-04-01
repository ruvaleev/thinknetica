require 'rails_helper'

feature 'Show question and create answer', %q{
	In order to see question
	As an authentificated user
	I wanted to give answer
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }
  given(:another_answer) { create(:answer, question: question) }

  scenario 'User see the question' do      
    visit question_path(question)
    expect(page).to have_text(question.body) 
  end

  scenario 'User see the answers for the question' do
    visit question_path(question)
    expect(page).to have_text(answer.body)
    expect(page).to have_text(another_answer.body)
  end

  scenario "User can't see the delete button near the other users answers" do 
    sign_in(user)
    another_answer
    visit question_path(question)
    expect(page).to have_no_text('Delete')
  end

  scenario 'User see the delete button near his own answer' do      
    sign_in(user)
    answer
    visit question_path(question)
    expect(page).to have_text('Delete') 
  end

end