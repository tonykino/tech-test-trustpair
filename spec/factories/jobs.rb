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

FactoryBot.define do
  factory :job do
    year { "MyString" }
    collectivity { "MyString" }
    contract_type { "MyString" }
    job { "MyString" }
    level { "MyString" }
    specialty { "MyString" }
  end
end
