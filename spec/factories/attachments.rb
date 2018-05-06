FactoryBot.define do
  factory :attachment_for_question do
    file fixture_file_upload("#{Rails.root}/spec/spec_helper.rb")
    attachable question
  end

  factory :attachment_for_answer do
    file fixture_file_upload("#{Rails.root}/spec/spec_helper.rb")
    attachable answer
  end
end
