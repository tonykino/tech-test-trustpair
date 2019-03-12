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
  subject do
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
end
