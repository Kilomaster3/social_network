# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:account) { FactoryBot.create(:account) }
  let(:post) { FactoryBot.create(:post, account: account) }

  context 'when valid params' do
    it 'when valid post' do
      expect(post).to be_valid
    end

    describe 'when account_id is present' do
      it 'accounts id should be present' do
        expect(post).to be_valid
      end
    end

    it 'title should be less 180 chars' do
      title = 'a' * 180
      expect(FactoryBot.build(:post, title: title)).to be_valid
    end

    it 'content should be present chars' do
      content = 'a' * 180
      expect(FactoryBot.build(:post, content: content)).to be_valid
    end
  end

  context 'with invalid params' do
    describe 'when account_id is not present' do
      before { post.account_id = nil }

      it 'accounts id should be present' do
        expect(post).not_to be_valid
      end
    end

    it 'title should be no longer than 180 chars' do
      title = 'a' * 181
      expect(FactoryBot.build(:post, title: title)).not_to be_valid
    end

    it 'content should be no longer than 180 chars' do
      content = 'a' * 181
      expect(FactoryBot.build(:post, content: content)).not_to be_valid
    end

    it 'title should have more than to 2 chars' do
      title = 'a'
      expect(FactoryBot.build(:post, title: title)).not_to be_valid
    end

    it 'content should be no shorter than 2 chars' do
      content = 'a'
      expect(FactoryBot.build(:post, content: content)).not_to be_valid
    end
  end

  context 'when filters' do
    it 'order should be last post created' do
      expect(described_class.search_last_post).to match_array(post)
    end
  end
end
