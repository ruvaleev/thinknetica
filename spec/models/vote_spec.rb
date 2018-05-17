require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :object }
  it { should belong_to :user }

  it { should validate_presence_of :object_id }
  it { should validate_presence_of :user_id }
end
