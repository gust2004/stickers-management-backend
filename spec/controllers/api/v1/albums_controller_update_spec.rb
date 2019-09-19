# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::AlbumsController, type: :request do
  let(:headers_params) { { 'Content-Type': 'application/json' } }

  let(:album) { create(:album) }
  let(:album_uuid) { album.uuid }
  let(:body_params) do
    {
      name: 'Novo Nome', description: 'Nova Descrição',
      number_of_stickers: 250
    }
  end

  subject do
    put "/api/v1/albums/#{album_uuid}", params: body_params.to_json, headers: headers_params
    response
  end

  context 'when album is not found' do
    let(:album_uuid) { SecureRandom.uuid }

    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when update an album successfuly' do
    it { is_expected.to have_http_status(:ok) }
    it { expect(parsed_body(subject.body)[:name]).to eql('Novo Nome') }
    it { expect(parsed_body(subject.body)[:description]).to eql('Nova Descrição') }
    it { expect(parsed_body(subject.body)[:number_of_stickers]).to eql(250) }
  end

  context 'when could not update an album due to missing params' do
    let(:body_params) { {} }

    it { is_expected.to have_http_status(:bad_request) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS010') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('Parâmetro album obrigatório') }
  end

  context 'when could not update an album due to missing number_of_stickers param' do
    let(:body_params) { { number_of_stickers: nil } }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS007') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('O número de figurinhas do álbum é obrigatório') }
  end

  context 'when could not create an album due to missing name param' do
    let(:body_params) { { name: nil } }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS005') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('O nome do álbum é obrigatório') }
  end

  context 'when could not update an album due to repeated name' do
    let(:other_album) { create(:album) }
    let(:body_params) do
      {
        name: other_album.name, description: 'Nova Descrição',
        number_of_stickers: 250
      }
    end

    it { is_expected.to have_http_status(:unprocessable_entity) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS006') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('Já existe um álbum com este nome') }
  end
end
