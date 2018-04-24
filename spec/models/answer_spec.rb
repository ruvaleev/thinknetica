require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { create(:answer) }
  
  it { should belong_to :question }
  it { should validate_presence_of :body }

  it 'makes best' do
    answer.make_best
    expect( answer.award ).to be_truthy 
  end
end
