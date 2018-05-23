require 'rails_helper'

RSpec.describe Vote, type: :model do
  let!(:answer) { create(:answer) }
  let!(:author) { create(:user) }
  let!(:vote) { create(:vote_for_answer, user: author, object: answer, object_type: 'Answer', value: 1) }
  let(:duplicate_vote) { create(:vote_for_answer, user: author, object: answer, object_type: 'Answer', value: 1) }

  it { should belong_to :object }
  it { should belong_to :user }

end
