# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DatetimeUtil do
  describe '.convert_to_miliseconds' do
    subject { DatetimeUtil.convert_to_miliseconds(datetime) }

    context 'when datetime is nil' do
      let(:datetime) { nil }

      it { expect(subject).to be_nil }
    end

    context 'when datetime is not a DateTime class type' do
      let(:datetime) { Time.now }

      it { expect(subject).to be_nil }
    end

    context 'when datetime is valid' do
      let(:datetime) { DateTime.now }

      it { expect(subject).to_not be_nil }
    end
  end
end
