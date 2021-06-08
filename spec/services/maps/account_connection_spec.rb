# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Maps::AccountConnection, type: :service do
  describe '#call' do
    subject(:all_accounts) { described_class.call(params) }

    let(:interests) { 50 }
    let(:full_name_path) { 'Paris Jebo' }

    context 'with default interests' do
      let(:params) { { id: account.id, interests: 50 } }

      it { expect(interests).to eq(50) }
    end

    context 'with default name' do
      let(:params) { { id: account.id, full_name_path: full_name_path } }

      it { expect(full_name_path).to eq('Paris Jebo') }
    end
  end
end
