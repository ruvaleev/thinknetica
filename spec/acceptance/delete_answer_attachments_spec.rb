require_relative 'acceptance_helper'

feature 'Delete answer attachments', %q{
  In order to edit my answer
  As an answers author
  I want to be able to delete attachments
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:my_answer) { create(:answer, question: question, user: user) }
  given(:not_my_answer) { create(:answer, question: question) }
  given(:my_attachment) { create(:attachment, attachable: my_answer) }
  given(:not_my_answer) { create(:attachment, attachable: not_my_answer) }

  scenario "Answer's author can delete an attachment" 
  scenario "User try to delete another user's answer's attachment"

end