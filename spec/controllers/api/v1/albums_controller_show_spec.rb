# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::AlbumsController, type: :request do
  let(:headers_params) { { 'Content-Type': 'application/json' } }

  subject do
    get "/api/v1/albums/#{album_uuid}", headers: headers_params
    response
  end

  context 'when is album not found' do
    let(:album_uuid) { SecureRandom.uuid }

    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when album is found' do
    let(:album) { create(:album) }
    let(:album_uuid) { album.uuid }

    it { expect(subject).to have_http_status(:ok) }
    it { expect(parsed_body(subject.body)[:name]).to eql(album.name) }
    it { expect(parsed_body(subject.body)[:description]).to eql(album.description) }
    it { expect(parsed_body(subject.body)[:number_of_stickers]).to eql(album.number_of_stickers) }
  end
end
