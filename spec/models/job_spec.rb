# frozen_string_literal: true

# == Schema Information
#
# Table name: jobs
#
#  id               :bigint(8)        not null, primary key
#  year             :string
#  contract_type    :string
#  job              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  men_workforces   :integer
#  women_workforces :integer
#

require 'rails_helper'

RSpec.describe Job, type: :model do
  subject(:job) do
    build(:job)
  end

  describe 'is creatable' do
    let(:job) { create(:job) }

    it { expect(job.id).not_to be_nil }
    it { expect(job.job).not_to be_nil }
  end

  describe 'with_workforces' do
    let(:job) { create(:job, :with_workforces) }

    it { expect(job.id).not_to be_nil }
    it { expect(job.job).not_to be_nil }
    it { expect(job.men_workforces).not_to be_nil }
  end

  describe 'Database' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:year).of_type(:string) }
    it { is_expected.to have_db_column(:contract_type).of_type(:string) }
    it { is_expected.to have_db_column(:job).of_type(:string) }
    it { is_expected.to have_db_column(:men_workforces).of_type(:integer) }
    it { is_expected.to have_db_column(:women_workforces).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'Validations' do
    it { is_expected.to validate_inclusion_of(:year).in_array(%w(2013 2014 2015)) }
    it { is_expected.to validate_inclusion_of(:contract_type).in_array(['TEMPS COMPLET', 'TEMPS INCOMPLET']) }
    it { is_expected.to validate_presence_of(:job) }
  end

  describe '.global_workforces' do
    context 'without API call' do
      it { expect(job.global_workforces).to eq('NC') }
      it { expect(job.global_workforces.class).to be(String) }
    end

    context 'with API call' do
      subject(:job) { build(:job, :with_workforces) }

      let(:workforces) { job.men_workforces + job.women_workforces }

      it { expect(job.global_workforces).to eq(workforces) }
      it { expect(job.global_workforces.class).to be(Integer) }
    end
  end

  describe '.men_percentage' do
    context 'without API call' do
      it { expect(job.men_percentage).to eq('NC') }
      it { expect(job.men_percentage.class).to be(String) }
    end

    context 'with API call' do
      subject(:job) { build(:job, :with_workforces) }

      let(:percentage) { job.men_workforces * 100 / job.global_workforces }

      it { expect(job.men_percentage).to eq(percentage) }
      it { expect(job.men_percentage.class).to be(Integer) }
    end
  end

  describe '.women_percentage' do
    context 'without API call' do
      it { expect(job.women_percentage).to eq('NC') }
      it { expect(job.women_percentage.class).to be(String) }
    end

    context 'with API call' do
      subject(:job) { build(:job, :with_workforces) }

      let(:percentage) { job.women_workforces * 100 / job.global_workforces }

      it { expect(job.women_percentage).to eq(percentage) }
      it { expect(job.women_percentage.class).to be(Integer) }
    end
  end

  describe '.parity_score' do
    context 'without API call' do
      it { expect(job.parity_score).to eq('NC') }
      it { expect(job.parity_score.class).to be(String) }
    end

    context 'with API call' do
      subject(:job) { build(:job, :with_workforces) }

      let(:score) { (job.men_percentage - job.women_percentage).abs }

      it { expect(job.parity_score).to eq(score) }
      it { expect(job.parity_score.class).to be(Integer) }
    end
  end

  describe '.parity_valid?' do
    context 'without API call' do
      it { expect(job.parity_valid?).to be false }
    end

    context 'with API call and parity valid' do
      subject(:job) { build(:job, :with_workforces, men_workforces: 15, women_workforces: 16 ) }

      let(:result) { job.parity_score < 15 }

      it { expect(job.parity_valid?).to be result }
    end

    context 'with API call and parityr invalid' do
      subject(:job) { build(:job, :with_workforces, men_workforces: 2, women_workforces: 128 ) }

      let(:result) { job.parity_score < 15 }

      it { expect(job.parity_valid?).to be result }
    end
  end
end
