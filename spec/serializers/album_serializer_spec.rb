# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AlbumSerializer, type: :serializer do
  let(:album) { create(:album) }
  let(:serializer) { AlbumSerializer.new(album) }

  subject { JSON.parse(serializer.to_json, symbolize_names: true) }

  context 'when serializer album object' do
    it { expect(subject[:id]).to eql(album.uuid) }
    it { expect(subject[:name]).to eql(album.name) }
    it { expect(subject[:description]).to eql(album.description) }
    it { expect(subject[:number_of_stickers]).to eql(album.number_of_stickers) }
    it do
      expect(subject[:created_at]).to eql(
        parse_datetime_to_milliseconds(album.created_at.to_datetime)
      )
    end
    it do
      expect(subject[:updated_at]).to eql(
        parse_datetime_to_milliseconds(album.updated_at.to_datetime)
      )
    end
  end

  def parse_datetime_to_milliseconds(datetime)
    DatetimeUtil.convert_to_miliseconds(datetime)
  end
end
