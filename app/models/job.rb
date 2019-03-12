# frozen_string_literal: true

# == Schema Information
#
# Table name: jobs
#
#  id               :bigint(8)        not null, primary key
#  year             :string
#  collectivity     :string
#  contract_type    :string
#  job              :string
#  level            :string
#  specialty        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  men_workforces   :integer          default(0)
#  women_workforces :integer          default(0)
#

include OpendataParisApi

class Job < ApplicationRecord
  MAX_WANTED_PARITY = 15

  def self.create_and_complete(params)
    return if Job.find_by(params)

    job = Job.create!(params)
    ParisApiCallJob.perform_later(job)
  end

  def complete_with_workforces_from_api_data
    response = OpendataParisApi.get_api_data(year, contract_type, job)
    JSON.parse(response)['records'].each do |record|
      self.men_workforces += record['fields']['nombre_d_hommes'].to_i
      self.women_workforces += record['fields']['nombre_de_femmes'].to_i
    end
    save
  end

  def global_workforces
    men_workforces + women_workforces
  end

  def men_percentage
    global_workforces.zero? ? 0 : men_workforces * 100 / global_workforces
  end

  def women_percentage
    global_workforces.zero? ? 0 : women_workforces * 100 / global_workforces
  end

  def parity_score
    (men_percentage - women_percentage).abs
  end

  def parity_valid?
    parity_score < MAX_WANTED_PARITY
  end
end
