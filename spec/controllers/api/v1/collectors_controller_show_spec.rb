# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::CollectorsController, type: :request do
  let(:headers_params) { { 'Content-Type': 'application/json' } }

  subject do
    get "/api/v1/collectors/#{collector_uuid}", headers: headers_params
    response
  end

  context 'when is collector not found' do
    let(:collector_uuid) { SecureRandom.uuid }

    it { is_expected.to have_http_status(:not_found) }
  end

  context 'when collector is found' do
    let(:collector) { create(:collector) }
    let(:collector_uuid) { collector.uuid }

    it { expect(subject).to have_http_status(:ok) }
    it { expect(parsed_body(subject.body)[:name]).to eql(collector.name) }
    it { expect(parsed_body(subject.body)[:email]).to eql(collector.email) }
  end
end
