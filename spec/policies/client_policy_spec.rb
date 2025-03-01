# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClientPolicy, type: :policy do
  subject { described_class.new(user, client) }

  let(:client) { Client.new }

  context 'with visitors' do
    let(:user) { nil }

    it 'raises NotAuthorizedError' do
      expect { subject.index? }.to raise_error(Pundit::NotAuthorizedError)
    end
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
