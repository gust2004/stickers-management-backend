# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Collector, type: :model do
  subject { collector }

  describe '.valid?' do
    context 'when collector is valid' do
      let(:collector) { build(:collector) }

      it { expect(subject).to be_valid }
    end

    context 'when collector is invalid because does not have name' do
      let(:collector) { build(:collector_without_name) }

      it { expect(subject).to_not be_valid }
    end

    context 'when collector is invalid because does not have email' do
      let(:collector) { build(:collector_without_email) }

      it { expect(subject).to_not be_valid }
    end

    context 'when collector is invalid because already exists an collector with the same email' do
      let(:first_collector) { create(:collector) }
      let(:collector) { build(:collector, email: first_collector.email) }

      it { expect(subject).to_not be_valid }
    end

    context 'when collector is invalid because already exists an collector with the same uuid' do
      let(:first_collector) { create(:collector) }
      let(:collector) { build(:collector, uuid: first_collector.uuid) }

      it { expect(subject).to_not be_valid }
    end

    context 'when collector is invalid because email is invalid' do
      let(:collector) { build(:collector_with_invalid_email) }

      it { expect(subject).to_not be_valid }
    end
  end

  describe '.by_uuid' do
    context 'when find created collector by uuid' do
      let(:collector) { create(:collector) }

      it do
        subject
        expect(Collector.by_uuid(collector.uuid).first).to_not be_nil
      end
    end

    context 'when could not find collector by uuid' do
      it { expect(Collector.by_uuid('uuid').first).to be_nil }
    end
  end
end
