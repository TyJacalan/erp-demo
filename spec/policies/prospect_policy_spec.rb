require 'rails_helper'

RSpec.describe ProspectPolicy, type: :policy do
  subject { described_class.new(user, prospect) }

  let(:organization) { Organization.new }
  let(:prospect) { organization.build_prospect }

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
