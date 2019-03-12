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

FactoryBot.define do
  factory :job do
    year { ['2013', '2014', '2015'].sample }
    contract_type { ['TEMPS INCOMPLET', 'TEMPS COMPLET'].sample }
    job { Faker::Alphanumeric.alphanumeric 32 }

    trait(:with_workforces) do
      men_workforces { rand(100) }
      women_workforces { rand(100) }
    end
  end
end
