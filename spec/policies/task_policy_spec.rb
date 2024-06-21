# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskPolicy, type: :policy do
  subject { described_class.new(user, task) }

  let(:task) { Task.new }

  context 'with visitors' do
    let(:user) { nil }

    it 'raises NotAuthorizedError' do
      expect { subject.index? }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'for a non client manager' do
    let(:user) { User.new }

    it { is_expected.to permit_only_actions(%i[index]) }
  end

  context 'for task managers' do
    let(:user) { User.new(task_manager: true) }
    it { is_expected.to permit_all_actions }
  end
end
