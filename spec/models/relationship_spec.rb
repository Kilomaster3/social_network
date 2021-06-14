# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:follower) { FactoryBot.create(:account) }
  let(:followed) { FactoryBot.create(:account) }
  let(:relationship) { FactoryBot.create(:relationship, follower: follower, followed: followed) }

  it 'when relationship valid' do
    expect(relationship).to be_valid
  end

  describe 'require a follower_id' do
    before { relationship.follower_id = nil }

    it 'when follower_id is not present' do
      expect(relationship).not_to be_valid
    end
  end

  describe 'require a followed_id' do
    before { relationship.followed_id = nil }

    it 'when followed_id is not present' do
      expect(relationship).not_to be_valid
    end
  end
end
