FactoryBot.define do
  factory :answer do
    user
    question
    body "MyText"
  end

  factory :invalid_answer, class: "Question" do
    user
    question
    body nil
  end
end
