# frozen_string_literal: true

# == Schema Information
#
# Table name: jobs
#
#  id            :bigint(8)        not null, primary key
#  year          :string
#  collectivity  :string
#  contract_type :string
#  job           :string
#  level         :string
#  specialty     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Job < ApplicationRecord
  def self.create_or_update(params)
    Job.create!(params) unless Job.find_by(params)
  end
end
