require 'rails_helper'

RSpec.describe ProgramPolicy, type: :policy do
  subject { described_class.new(user, program) }

  let(:organization) { Program.new }

  context 'with visitors' do
    let(:user) { nil }

    it 'raises NotAuthorizedError' do
      expect { subject.index? }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'for authenticated users' do
    let(:user) { User.new }

    it { is_expected.to permit_all_actions }
  end
end
