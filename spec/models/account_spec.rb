# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) { FactoryBot.create(:account) }
  let(:other_account) { FactoryBot.create(:account) }

  describe Account do
    context 'with valid email' do
      let(:email) { FactoryBot.create(:account) }

      it 'reject duplicate email addresses' do
        expect(email).to be_valid
      end

      it 'build accounts with valid email address' do
        expect(account).to be_valid
      end

      it 'accept valid email addresses' do
        addresses = %w[member@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
          valid_email_user = FactoryBot.build(:account, email: address)
          expect(valid_email_user).to be_valid
        end
      end
    end

    context 'when account upto case email' do
      let(:account) { FactoryBot.create(:account, email: 'TEST@EXAMPLE.ORG') }

      it 'create user with upto case email' do
        expect(account).to be_valid
      end
    end

    context 'when valid params' do
      let(:account) { FactoryBot.create(:account) }

      it 'correct email and password' do
        expect(account).to be_valid
      end

      it 'accept long password' do
        long = 'Aa1' * 10
        expect(FactoryBot.build(:account, password: long, password_confirmation: long)).to be_valid
      end

      it 'first name should be present' do
        name = 'John'
        expect(FactoryBot.build(:account, first_name: name)).to be_valid
      end

      it 'last name should be present' do
        surname = 'Johnson'
        expect(FactoryBot.build(:account, last_name: surname)).to be_valid
      end

      it 'connection should be present' do
        connection = 40
        expect(FactoryBot.build(:account, connection: connection)).to be_valid
      end

      it 'max connection should be present' do
        max_connection = 60
        expect(FactoryBot.build(:account, max_connection: max_connection)).to be_valid
      end
    end

    context 'when invalid params' do
      it 'require a matching password confirmation' do
        expect(FactoryBot.build(:account, password_confirmation: 'invalid')).not_to be_valid
      end

      it 'reject short passwords' do
        short_password = 'a' * 5
        expect(FactoryBot.build(:account, password: short_password, password_confirmation: short_password)).not_to be_valid
      end

      it 'first name should be present' do
        name = nil
        expect(FactoryBot.build(:account, first_name: name)).not_to be_valid
      end

      it 'last name should be present' do
        surname = nil
        expect(FactoryBot.build(:account, last_name: surname)).not_to be_valid
      end

      it 'without params' do
        expect(described_class.new).to be_invalid
      end
    end

    describe '#following' do
      it 'expect relationship between two accounts to be empty' do
        account.following?(other_account)

        expect(account.active_relationships).to be_empty
      end
    end

    describe '#follow' do
      it 'creates the active relationship between two accounts' do
        account.follow(other_account)
        expect(account.active_relationships.first.followed_id).to eq(other_account.id)
      end

      it 'creates the passive relationship between two accounts' do
        account.follow(other_account)
        expect(other_account.passive_relationships.first.follower_id).to eq(account.id)
      end
    end

    context 'with valid factory' do
      it 'has a valid factory' do
        expect(account).to be_valid
      end
    end
  end
end
