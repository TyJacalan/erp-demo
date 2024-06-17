# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClientPolicy, type: :policy do
  subject { described_class.new(user, client) }

  let(:client) { Client.new }

  context 'for a visitor' do
    let(:user) { nil }

    it { is_expected.to forbid_all_actions }
  end

  context 'for a non client manager' do
    let(:user) { User.new }

    it { is_expected.to permit_only_actions(%i[index show]) }
  end

  context 'for client managers' do
    let(:user) { User.new(client_manager: true) }
    it { is_expected.to permit_all_actions }
  end
end
