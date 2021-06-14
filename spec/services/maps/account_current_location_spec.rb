# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Maps::AccountCurrentLocation, type: :service do
  describe '#call' do
    subject(:current_account) { described_class.call(params) }

    let(:full_name_path) { 'Denis Rubis' }

    context 'with default name' do
      let(:params) { { id: account.id, full_name_path: full_name_path } }

      it { expect(full_name_path).to eq('Denis Rubis') }
    end
  end
end
