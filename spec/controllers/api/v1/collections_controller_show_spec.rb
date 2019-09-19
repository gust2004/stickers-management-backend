# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::CollectionsController, type: :request do
  let(:headers_params) { { 'Content-Type': 'application/json' } }
  let(:collector_uuid) { SecureRandom.uuid }
  let(:collection_uuid) { SecureRandom.uuid }

  subject do
    get "/api/v1/collectors/#{collector_uuid}/collections/#{collection_uuid}", headers: headers_params
    response
  end

  context 'when collector is not found' do
    let(:collector_uuid) { 'no_uuid' }

    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when collection is not found' do
    let(:collection_uuid) { 'no_uuid' }

    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when collection is found' do
    let(:collector) { create(:collector, uuid: collector_uuid) }
    let(:collection) { create(:collection, uuid: collection_uuid, collector: collector) }

    before { collection }

    it { expect(subject).to have_http_status(:ok) }
  end
end
