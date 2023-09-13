# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CreateApplication::Contract, type: :contract do
  let(:job) { create(:job) }
  let(:person) { create(:person) }
  let(:call) { described_class.new.(params) }
  let(:errors) { call.errors.to_h }

  context 'when contract is accepted' do
    let(:params) do
      {
        id_vaga: job.id,
        id_pessoa: person.id
      }
    end

    it 'must be able to return a Success Result' do
      expect(call).to be_success
    end
  end

  context 'when the person not exists' do
    let(:params) do
      {
        id_vaga: job.id,
        id_pessoa: 0
      }
    end

    let(:expected_errors) do
      {
        id_pessoa: [I18n.t('dry_validation.errors.person_not_found')]
      }
    end

    it 'must be able to return a person_not_found message error' do
      expect(errors).to eq(expected_errors)
    end
  end

  context 'when the job not exists' do
    let(:params) do
      {
        id_vaga: 0,
        id_pessoa: person.id
      }
    end

    let(:expected_errors) do
      {
        id_vaga: [I18n.t('dry_validation.errors.job_not_found')]
      }
    end

    it 'must be able to return a job_not_found message error' do
      expect(errors).to eq(expected_errors)
    end
  end

  context 'when the person has already applied for the vacancy' do
    let(:application) { create(:application) }
    let(:params) do
      {
        id_vaga: application.job_id,
        id_pessoa: application.person_id
      }
    end

    let(:expected_errors) do
      {
        application: [I18n.t('dry_validation.errors.already_applied')]
      }
    end

    it 'must be able to return a already_applied message error' do
      expect(errors).to eq(expected_errors)
    end
  end
end
