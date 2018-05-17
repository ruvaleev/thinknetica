FactoryBot.define do
  factory :vote_for_answer, class: 'Vote' do
    user
    object_type 'Answer'
  end

  factory :vote_for_question, class: 'Vote' do
    user
    object_type 'Question'
  end
end
