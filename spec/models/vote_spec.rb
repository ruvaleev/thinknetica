require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :object }
  it { should belong_to :user }

end
