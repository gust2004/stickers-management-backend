# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollectorSerializer, type: :serializer do
  let(:collector) { create(:collector) }
  let(:serializer) { CollectorSerializer.new(collector) }

  subject { JSON.parse(serializer.to_json, symbolize_names: true) }

  context 'when serializer collector object' do
    it { expect(subject[:id]).to eql(collector.uuid) }
    it { expect(subject[:name]).to eql(collector.name) }
    it { expect(subject[:email]).to eql(collector.email) }
    it do
      expect(subject[:created_at]).to eql(
        parse_datetime_to_milliseconds(collector.created_at.to_datetime)
      )
    end
    it do
      expect(subject[:updated_at]).to eql(
        parse_datetime_to_milliseconds(collector.updated_at.to_datetime)
      )
    end
  end

  def parse_datetime_to_milliseconds(datetime)
    DatetimeUtil.convert_to_miliseconds(datetime)
  end
end
