# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::StickersController, type: :request do
  let(:headers_params) { { 'Content-Type': 'application/json' } }
  let(:collection) { create(:collection) }
  let(:collector_uuid) { collection.collector.uuid }
  let(:collection_uuid) { collection.uuid }

  subject do
    get "/api/v1/collectors/#{collector_uuid}/collections/#{collection_uuid}/stickers", headers: headers_params
    response
  end

  context 'when collection is not found' do
    let(:collection_uuid) { SecureRandom.uuid }

    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when stickers are not found' do
    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when there is one sticker found' do
    let(:sticker) { create(:sticker) }
    let(:collection) { sticker.collection }

    it { expect(subject).to have_http_status(:ok) }
    it { expect(parsed_body(subject.body)[0][:number]).to eql(sticker.number) }
    it { expect(parsed_body(subject.body)[0][:quantity]).to eql(sticker.quantity) }
    it { expect(parsed_body(subject.body)[0][:status]).to eql(Sticker::REPEATED) }
    it { expect(parsed_body(subject.body)[0][:number_of_repeated]).to eql(9) }
  end

  context 'when there are more than one sticker found' do
    let(:sticker) { create(:sticker) }
    let(:collection) { sticker.collection }

    before do
      create(:sticker, collection: collection)
    end

    it { expect(subject).to have_http_status(:ok) }
    it { expect(parsed_body(subject.body).size).to eql(2) }
  end
end
