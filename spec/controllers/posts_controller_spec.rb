# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:account) { FactoryBot.create(:account) }
  let(:post_record) { FactoryBot.create(:post, account_id: account.id) }

  describe 'GET #index' do
    context 'when guest' do
      it 'return success response' do
        get :index
        expect(response).to be_redirect
      end
    end

    context 'when accounts login' do
      before { sign_in(account, scope: :account) }

      it 'success' do
        get :index
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST #create' do
    context 'when guest accounts' do
      it 'returns a 302 request' do
        get :create
        expect(response.status).to eq 302
      end

      it 'redirects the page to /accounts/sign_in' do
        get :create
        expect(response).to redirect_to '/accounts/sign_in'
      end
    end

    context 'when authorized accounts' do
      it 'adds a new post' do
        sign_in account

        expect { post :create, params: { post: { title: 'Test', content: 'Test UP ？!', account_id: 1 } } }.to change(Post, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'when title nil' do
        sign_in account
        post :create, params: { post: { title: nil, content: 'Test UP ？!', account_id: 1 } }

        expect(response.status).not_to eq(422)
      end
    end
  end

  describe 'GET #show' do
    context 'when authorized accounts' do
      it 'responds successfully' do
        sign_in account

        get :show, params: { id: post_record.id }
        expect(response.status).to eq 200
      end

      it 'does not respond successfully' do
        sign_in account

        get :show, params: { id: post_record.id }
        expect(response).not_to redirect_to '/post/id'
      end

      it 'redirects the page to /accounts/sign_in' do
        get :show, params: { id: post_record.id }
        expect(response).to redirect_to '/accounts/sign_in'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when authorized accounts' do
      it 'deletes an post' do
        sign_in account

        delete :destroy, params: { id: post_record.id }
        expect(account).to be_valid
      end

      it 'redirects the page to root_path' do
        sign_in account

        delete :destroy, params: { id: post_record.id }
        expect(response).to redirect_to root_path
      end

      it 'returns a 302 response' do
        delete :destroy, params: { id: post_record.id }
        expect(response.status).to eq 302
      end

      it 'redirects the page to /accounts/sign_in' do
        delete :destroy, params: { id: post_record.id }
        expect(response).to redirect_to '/accounts/sign_in'
      end
    end
  end
end
