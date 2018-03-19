FactoryBot.define do
  factory :answer do
    body "MyText"
  end

  factory :invalid_answer, class: "Question" do
    body nil
  end
end
