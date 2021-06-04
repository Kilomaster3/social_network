# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Accounts::ProfileController, type: :controller do
  let(:account) { FactoryBot.create(:account) }

  describe 'GET #index' do
    let(:accounts) { FactoryBot.create_list(:account, 2) }

    context 'when account authorize' do
      before { sign_in(account, scope: :account) }

      it 'look me up' do
        get :index
        expect(assigns(:accounts)).to eq(accounts)
      end
    end
  end

  context 'when unauthenticated' do
    it 'Not authenticated account is redirected' do
      get :index
      expect(response.status).to eq(302)
    end
  end

  describe 'GET #show' do
    context 'when unauthenticated' do
      it 'Check if accounts login into system' do
        get :show, params: { id: account.id }
        expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
      end
    end
  end

  describe 'PATCH #update' do
    context 'with good data' do
      it 'updates the connection and redirects' do
        patch :update, params: { id: account.id, account: { name: 'xyz', connection: 99 } }
        expect(response).to be_redirect
      end

      it 'updates the email and redirects' do
        patch :update, params: { id: account.id, account: { first_name: 'xyz', email: 'my_name@example.com' } }
        expect(response).to be_redirect
      end
    end
  end
end
