# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollectionSerializer, type: :serializer do
  let(:collection) { create(:collection) }
  let(:serializer) { CollectionSerializer.new(collection) }

  subject { JSON.parse(serializer.to_json, symbolize_names: true) }

  context 'when serializer collector object' do
    it { expect(subject[:id]).to eql(collection.uuid) }
    it do
      expect(subject[:created_at]).to eql(
        parse_datetime_to_milliseconds(collection.created_at.to_datetime)
      )
    end
    it do
      expect(subject[:updated_at]).to eql(
        parse_datetime_to_milliseconds(collection.updated_at.to_datetime)
      )
    end
    it { expect(subject[:collector][:id]).to eql(collection.collector.uuid) }
    it { expect(subject[:collector][:name]).to eql(collection.collector.name) }
    it { expect(subject[:collector][:email]).to eql(collection.collector.email) }
    it do
      expect(subject[:collector][:created_at]).to eql(
        parse_datetime_to_milliseconds(collection.collector.created_at.to_datetime)
      )
    end
    it do
      expect(subject[:collector][:updated_at]).to eql(
        parse_datetime_to_milliseconds(collection.collector.updated_at.to_datetime)
      )
    end
    it { expect(subject[:album][:id]).to eql(collection.album.uuid) }
    it { expect(subject[:album][:name]).to eql(collection.album.name) }
    it { expect(subject[:album][:description]).to eql(collection.album.description) }
    it { expect(subject[:album][:number_of_stickers]).to eql(collection.album.number_of_stickers) }
    it do
      expect(subject[:album][:created_at]).to eql(
        parse_datetime_to_milliseconds(collection.album.created_at.to_datetime)
      )
    end
    it do
      expect(subject[:album][:updated_at]).to eql(
        parse_datetime_to_milliseconds(collection.album.updated_at.to_datetime)
      )
    end
  end

  def parse_datetime_to_milliseconds(datetime)
    DatetimeUtil.convert_to_miliseconds(datetime)
  end
end
