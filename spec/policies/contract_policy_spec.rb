# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContractPolicy, type: :policy do
  subject { described_class.new(user, contract) }

  let(:contract) { Contract.new }

  context 'with visitors' do
    let(:user) { nil }

    it 'raises NotAuthorizedError' do
      expect { subject.index? }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end
