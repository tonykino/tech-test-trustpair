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
#  men_workforces   :integer
#  women_workforces :integer
#

require 'rails_helper'

RSpec.describe Job, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
