# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::AlbumsController, type: :request do
  let(:headers_params) { { 'Content-Type': 'application/json' } }
  let(:album) { build(:album) }
  let(:body_params) do
    {
      name: album.name, description: album.description,
      number_of_stickers: album.number_of_stickers
    }
  end

  subject do
    post '/api/v1/albums', params: body_params.to_json, headers: headers_params
    response
  end

  context 'when create an album successfuly' do
    it { is_expected.to have_http_status(:created) }
    it { expect(parsed_body(subject.body)[:name]).to eql(album.name) }
    it { expect(parsed_body(subject.body)[:description]).to eql(album.description) }
    it { expect(parsed_body(subject.body)[:number_of_stickers]).to eql(album.number_of_stickers) }
  end

  context 'when could not create an album due to missing params' do
    let(:body_params) { {} }

    it { is_expected.to have_http_status(:bad_request) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS010') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('Parâmetro album obrigatório') }
  end

  context 'when could not create an album due to missing number_of_stickers param' do
    let(:body_params) { { name: album.name } }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS007') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('O número de figurinhas do álbum é obrigatório') }
  end

  context 'when could not create an album due to missing name param' do
    let(:body_params) { { number_of_stickers: album.number_of_stickers } }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS005') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('O nome do álbum é obrigatório') }
  end

  context 'when could not create an album due to repeated name' do
    let(:album) { create(:album) }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS006') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('Já existe um álbum com este nome') }
  end
end
