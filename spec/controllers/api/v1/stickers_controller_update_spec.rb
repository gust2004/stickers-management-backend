# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::StickersController, type: :request do
  let(:headers_params) { { 'Content-Type': 'application/json' } }
  let(:sticker) { create(:sticker) }
  let(:sticker_uuid) { sticker.uuid }
  let(:collection) { sticker.collection }
  let(:collection_uuid) { collection.uuid }
  let(:collector_uuid) { collection.collector.uuid }
  let(:body_params) { { quantity: 3 } }

  subject do
    put "/api/v1/collectors/#{collector_uuid}/collections/#{collection_uuid}/stickers/#{sticker_uuid}",
        params: body_params.to_json, headers: headers_params
    response
  end

  context 'when sticker is not found' do
    let(:sticker_uuid) { SecureRandom.uuid }

    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when update an sticker successfuly' do
    it { is_expected.to have_http_status(:ok) }
    it { expect(parsed_body(subject.body)[:number]).to eql(sticker.number) }
    it { expect(parsed_body(subject.body)[:quantity]).to eql(3) }
    it { expect(parsed_body(subject.body)[:status]).to eql(Sticker::REPEATED) }
    it { expect(parsed_body(subject.body)[:number_of_repeated]).to eql(2) }
  end

  context 'when could not update an sticker due to missing params' do
    let(:body_params) { {} }

    it { is_expected.to have_http_status(:bad_request) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS010') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('Parâmetro sticker obrigatório') }
  end
end
