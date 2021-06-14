# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Maps::AccountMaxConnection, type: :service do
  describe '#call' do
    subject(:all_accounts) { described_class.call(params) }

    let(:max_interests) { 88 }

    context 'with default interests' do
      let(:params) { { id: account.id, interests: 88 } }

      it { expect(max_interests).to eq(88) }
    end
  end
end
