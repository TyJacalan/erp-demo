# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilePolicy, type: :policy do
  subject { described_class.new(user, nil) }

  context 'with visitors' do
    let(:user) { nil }

    it 'raises NotAuthorizedError' do
      expect { subject.index? }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'for a user' do
    let(:user) { User.new }

    it { is_expected.to permit_only_actions(%i[index]) }
  end
end
