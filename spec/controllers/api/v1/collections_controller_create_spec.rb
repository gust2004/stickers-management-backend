# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::CollectionsController, type: :request do
  let(:headers_params) { { 'Content-Type': 'application/json' } }
  let(:collector) { build(:collector) }
  let(:collector_uuid) { collector.uuid }
  let(:album) { build(:album) }
  let(:album_uuid) { album.uuid }
  let(:body_params) do
    { album_id: album_uuid }
  end

  subject do
    post "/api/v1/collectors/#{collector_uuid}/collections", params: body_params.to_json, headers: headers_params
    response
  end

  context 'when collector is not found' do
    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when album is not found' do
    let(:collector) { create(:collector) }

    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when create a collection successfuly' do
    let(:collector) { create(:collector) }
    let(:album) { create(:album) }

    it { is_expected.to have_http_status(:created) }
    it { expect(parsed_body(subject.body)[:collector]).to_not be_nil }
    it { expect(parsed_body(subject.body)[:album]).to_not be_nil }
  end
end
