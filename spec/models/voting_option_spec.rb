require 'rails_helper'

RSpec.describe VotingOption, type: :model do
  subject { FactoryGirl.build(:voting_option) }

  describe "validation" do
    it 'has a valid state' do
      expect(subject).to be_valid
    end

    it 'must have a voting type' do
      subject.voting_type = nil
      expect(subject).to_not be_valid
    end

    it 'must allow blank date objects' do
      subject.dates_and_deadlines = {}
      expect(subject).to be_valid
    end

    it 'must have valid date objects as dates' do
      skip
    end

    it 'must have valid keys for dates' do
      skip
    end
  end

  describe "default values" do
    subject { VotingOption.new }

    it 'has and empty array for dates and deadlines' do
      expect(subject.dates_and_deadlines).to eq({})
    end
  end
end
