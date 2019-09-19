# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Collection, type: :model do
  subject { collection }

  describe '.valid?' do
    context 'when collection is valid' do
      let(:collection) { build(:collection) }

      it { expect(subject).to be_valid }
    end

    context 'when collection is invalid because already exists an collection with the same uuid' do
      let(:first_collection) { create(:collection) }
      let(:collection) { build(:collection, uuid: first_collection.uuid) }

      it { expect(subject).to_not be_valid }
    end
  end

  describe '.by_uuid' do
    context 'when find created collection by uuid' do
      let(:collection) { create(:collection) }

      it do
        subject
        expect(Collection.by_uuid(collection.uuid).first).to_not be_nil
      end
    end

    context 'when could not find collection by uuid' do
      it { expect(Collection.by_uuid('uuid').first).to be_nil }
    end
  end

  describe '.by_collector' do
    context 'when find created collection by collector' do
      let(:collection) { create(:collection) }
      let(:collector) { collection.collector }

      it do
        subject
        expect(Collection.by_collector(collector).first).to_not be_nil
      end
    end

    context 'when could not find collection by uuid' do
      let(:collector) { create(:collector) }

      it { expect(Collection.by_collector(collector).first).to be_nil }
    end
  end
end
