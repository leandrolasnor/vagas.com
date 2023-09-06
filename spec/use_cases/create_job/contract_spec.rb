# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CreateJob::Contract', type: :contract do
  subject { CreateJob::Contract.new(locations: locations).(params) }

  let(:locations) { ['A', 'B', 'C'] }

  context 'when contract is accepted' do
    let(:params) do
      {
        empresa: 'Empresa',
        titulo: 'Titulo',
        descricao: 'Descricao',
        localizacao: 'A',
        nivel: 2
      }
    end

    it { is_expected.to be_success }
  end

  context 'when localizacao, nivel and titulo are invalids' do
    let(:params) do
      {
        empresa: '',
        descricao: 'Descricao',
        localizacao: 'Z',
        nivel: -1
      }
    end

    let(:expected_errors) do
      {
        localizacao: [I18n.t('dry_validation.errors.unknown_location')],
        nivel: ["must be one of: trainee, junior, full, senior, specialist"],
        titulo: ["is missing"],
        empresa: ["must be filled"]
      }
    end

    it 'must be able to get a failure messages' do
      expect(subject).to be_failure
      expect(subject.errors.to_h).to eq(expected_errors)
    end
  end
end
