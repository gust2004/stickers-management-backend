# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sticker, type: :model do
  subject { sticker }

  describe '.valid?' do
    context 'when sticker is valid' do
      let(:sticker) { build(:sticker) }

      it { expect(subject).to be_valid }
    end

    context 'when sticker is invalid because does not have number' do
      let(:sticker) { build(:sticker_without_number) }

      it { expect(subject).to_not be_valid }
    end

    context 'when sticker is invalid because already exists an sticker with the same uuid' do
      let(:first_sticker) { create(:sticker) }
      let(:sticker) { build(:sticker, uuid: first_sticker.uuid) }

      it { expect(subject).to_not be_valid }
    end
  end

  describe '.by_uuid' do
    context 'when find created sticker by uuid' do
      let(:sticker) { create(:sticker) }

      it do
        subject
        expect(Sticker.by_uuid(sticker.uuid).first).to_not be_nil
      end
    end

    context 'when could not find sticker by uuid' do
      it { expect(Sticker.by_uuid('uuid').first).to be_nil }
    end
  end

  describe '.by_collection' do
    context 'when find created sticker by collection' do
      let(:sticker) { create(:sticker) }

      it do
        subject
        expect(Sticker.by_collection(sticker.collection).first).to_not be_nil
      end
    end

    context 'when could not find sticker by collection' do
      let(:second_collection) { create(:collection) }

      it { expect(Sticker.by_collection(second_collection).first).to be_nil }
    end
  end

  describe '.missing' do
    context 'when find missing sticker' do
      let(:sticker) { create(:sticker, quantity: 0) }

      it do
        subject
        expect(Sticker.by_collection(sticker.collection).missing).to_not be_empty
      end
    end

    context 'when could not find missing sticker' do
      let(:sticker) { create(:sticker) }

      it { expect(Sticker.by_collection(sticker.collection).missing).to be_empty }
    end
  end

  describe '.used' do
    context 'when find used sticker' do
      let(:sticker) { create(:sticker, quantity: 1) }

      it do
        subject
        expect(Sticker.by_collection(sticker.collection).used).to_not be_empty
      end
    end

    context 'when could not used sticker' do
      let(:sticker) { create(:sticker) }

      it { expect(Sticker.by_collection(sticker.collection).used).to be_empty }
    end
  end

  describe '.repeated' do
    context 'when find repeated sticker' do
      let(:sticker) { create(:sticker, quantity: 3) }

      it do
        subject
        expect(Sticker.by_collection(sticker.collection).repeated).to_not be_empty
      end
    end

    context 'when could not repeated sticker' do
      let(:sticker) { create(:sticker, quantity: 0) }

      it { expect(Sticker.by_collection(sticker.collection).repeated).to be_empty }
    end
  end

  describe '.status' do
    context 'when sticker is missing' do
      let(:sticker) { create(:sticker, quantity: 0) }

      it { expect(sticker.status).to eql(Sticker::MISSING) }
    end

    context 'when sticker is used' do
      let(:sticker) { create(:sticker, quantity: 1) }

      it { expect(sticker.status).to eql(Sticker::USED) }
    end

    context 'when sticker is REPEATED' do
      let(:sticker) { create(:sticker, quantity: 2) }

      it { expect(sticker.status).to eql(Sticker::REPEATED) }
    end
  end

  describe '.number_of_repeated' do
    context 'when number of repeated is zero' do
      let(:sticker) { create(:sticker, quantity: 0) }

      it { expect(sticker.number_of_repeated).to eql(0) }
    end

    context 'when number of repeated is greater than zero' do
      let(:sticker) { create(:sticker, quantity: 2) }

      it { expect(sticker.number_of_repeated).to eql(1) }
    end
  end
end
