# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::CollectorsController, type: :request do
  let(:headers_params) { { 'Content-Type': 'application/json' } }
  let(:collector) { build(:collector) }
  let(:body_params) { { name: collector.name, email: collector.email } }

  subject do
    post '/api/v1/collectors', params: body_params.to_json, headers: headers_params
    response
  end

  context 'when create a collector successfuly' do
    it { is_expected.to have_http_status(:created) }
    it { expect(parsed_body(subject.body)[:name]).to eql(collector.name) }
    it { expect(parsed_body(subject.body)[:email]).to eql(collector.email) }
  end

  context 'when could not create a collector due to missing params' do
    let(:body_params) { {} }

    it { is_expected.to have_http_status(:bad_request) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS010') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('Parâmetro collector obrigatório') }
  end

  context 'when could not create a collector due to missing name param' do
    let(:body_params) { { email: collector.email } }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS001') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('O nome do colecionador é obrigatório') }
  end

  context 'when could not create a collector due to missing email param' do
    let(:body_params) { { name: collector.name } }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS002') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('O email do colecionador é obrigatório') }
  end

  context 'when could not create a collector due to repeated email' do
    let(:collector) { create(:collector) }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS003') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('Já existe um colecionador com este email') }
  end

  context 'when could not create a collector due to invalid email' do
    let(:body_params) { { name: collector.name, email: 'invalid email' } }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    it { expect(subject).to_not be_nil }
    it { expect(parsed_body(subject.body)).to be_instance_of(Hash) }
    it { expect(parsed_body(subject.body)[:errors]).to be_instance_of(Array) }
    it { expect(parsed_body(subject.body)[:errors].size).to eql(1) }
    it { expect(parsed_body(subject.body)[:errors][0][:code]).to eql('STICKERS004') }
    it { expect(parsed_body(subject.body)[:errors][0][:detail]).to eql('O email do colecionador não é um email válido') }
  end
end
