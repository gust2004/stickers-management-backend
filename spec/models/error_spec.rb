# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Error do
  let(:error) { Error.new }

  describe '.add' do
    subject { error.add(:'errors.messages.blank') }

    context 'when error message is added' do
      it { expect(subject).to be_instance_of(Error) }
      it { expect(subject.messages).to_not be_empty }
    end
  end

  describe '.add_all_messages' do
    let(:messages) { ['Error 1', 'Error 2'] }
    subject { error.add_all_messages(messages) }

    context 'when messages are added' do
      it { expect(subject).to be_instance_of(Error) }
      it { expect(subject.messages).to_not be_empty }
    end
  end
end
