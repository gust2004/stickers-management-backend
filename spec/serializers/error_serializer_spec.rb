# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ErrorSerializer do
  describe '.serialize' do
    subject { ErrorSerializer.serialize(error) }

    context 'when serialize error' do
      let(:error) do
        Error.new.add(
          :'activerecord.errors.models.collector.attributes.email.email'
        ).add(
          :'activerecord.errors.models.album.attributes.name.blank'
        )
      end

      it { expect(subject).to_not be_nil }
      it { expect(subject).to be_instance_of(Hash) }
      it { expect(subject[:errors]).to be_instance_of(Array) }
      it { expect(subject[:errors].size).to eql(2) }
      it { expect(subject[:errors][0][:code]).to eql('STICKERS004') }
      it { expect(subject[:errors][0][:detail]).to eql('O email do colecionador não é um email válido') }
      it { expect(subject[:errors][1][:code]).to eql('STICKERS005') }
      it { expect(subject[:errors][1][:detail]).to eql('O nome do álbum é obrigatório') }
    end

    context 'when there are no errors to serialize' do
      let(:error) { Error.new }

      it { expect(subject).to_not be_nil }
      it { expect(subject).to be_instance_of(Hash) }
      it { expect(subject[:errors]).to be_instance_of(Array) }
      it { expect(subject[:errors].empty?).to be_truthy }
    end

    context 'when errors do not have code' do
      let(:error) { Error.new.add_all_messages(['Error 1', 'Error 2']) }

      it { expect(subject).to_not be_nil }
      it { expect(subject).to be_instance_of(Hash) }
      it { expect(subject[:errors]).to be_instance_of(Array) }
      it { expect(subject[:errors].size).to eql(2) }
      it { expect(subject[:errors][0][:code]).to be_empty }
      it { expect(subject[:errors][0][:detail]).to eql('Error 1') }
      it { expect(subject[:errors][1][:code]).to be_empty }
      it { expect(subject[:errors][1][:detail]).to eql('Error 2') }
    end
  end
end
