# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::CollectionsController, type: :request do
  let(:headers_params) { { 'Content-Type': 'application/json' } }
  let(:collection) { create(:collection) }
  let(:collector) { collection.collector }
  let(:collector_uuid) { collector.uuid }

  subject do
    get "/api/v1/collectors/#{collector_uuid}/collections", headers: headers_params
    response
  end

  context 'when collector is not found' do
    let(:collector_uuid) { SecureRandom.uuid }

    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when there are no collections for collector' do
    let(:collector) { create(:collector) }
    let(:collector_uuid) { collector.uuid }

    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when there is one collection found' do
    it { expect(subject).to have_http_status(:ok) }
    it { expect(parsed_body(subject.body)[0][:collector][:name]).to eql(collection.collector.name) }
    it { expect(parsed_body(subject.body)[0][:album][:name]).to eql(collection.album.name) }
  end

  context 'when there are more than one collection found' do
    let(:second_collection) { create(:collection, collector: collector) }

    before { second_collection }

    it { expect(subject).to have_http_status(:ok) }
    it { expect(parsed_body(subject.body)[0][:collector][:name]).to eql(collection.collector.name) }
    it { expect(parsed_body(subject.body)[0][:album][:name]).to eql(collection.album.name) }
    it { expect(parsed_body(subject.body)[1][:collector][:name]).to eql(second_collection.collector.name) }
    it { expect(parsed_body(subject.body)[1][:album][:name]).to eql(second_collection.album.name) }
  end
end
