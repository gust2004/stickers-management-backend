# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::AlbumsController, type: :request do
  let(:headers_params) { { 'Content-Type': 'application/json' } }

  subject do
    get '/api/v1/albums', headers: headers_params
    response
  end

  context 'when there are no album registered' do
    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when there is one album found' do
    let(:album) { create(:album) }

    before { album }

    it { expect(subject).to have_http_status(:ok) }
    it { expect(parsed_body(subject.body)[0][:name]).to eql(album.name) }
    it { expect(parsed_body(subject.body)[0][:description]).to eql(album.description) }
    it { expect(parsed_body(subject.body)[0][:number_of_stickers]).to eql(album.number_of_stickers) }
  end

  context 'when there are more than one album found' do
    before do
      create(:album)
      create(:album)
    end

    it { expect(subject).to have_http_status(:ok) }
    it { expect(parsed_body(subject.body).size).to eql(2) }
  end
end
