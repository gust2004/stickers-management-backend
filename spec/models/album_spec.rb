# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Album, type: :model do
  subject { album }

  describe '.valid?' do
    context 'when album is valid' do
      let(:album) { build(:album) }

      it { expect(subject).to be_valid }
    end

    context 'when album is invalid because does not have name' do
      let(:album) { build(:album_without_name) }

      it { expect(subject).to_not be_valid }
    end

    context 'when album is invalid because does not have number of stickers' do
      let(:album) { build(:album_without_number_of_stickers) }

      it { expect(subject).to_not be_valid }
    end

    context 'when album is invalid because already exists an album with the same name' do
      let(:first_album) { create(:album) }
      let(:album) { build(:album, name: first_album.name) }

      it { expect(subject).to_not be_valid }
    end

    context 'when album is invalid because already exists an album with the same uuid' do
      let(:first_album) { create(:album) }
      let(:album) { build(:album, uuid: first_album.uuid) }

      it { expect(subject).to_not be_valid }
    end
  end

  describe '.by_uuid' do
    context 'when find created album by uuid' do
      let(:album) { create(:album) }

      it do
        subject
        expect(Album.by_uuid(album.uuid).first).to_not be_nil
      end
    end

    context 'when could not find album by uuid' do
      it { expect(Album.by_uuid('uuid').first).to be_nil }
    end
  end
end
