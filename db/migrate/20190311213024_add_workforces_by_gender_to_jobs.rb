# frozen_string_literal: true

class AddWorkforcesByGenderToJobs < ActiveRecord::Migration[5.2]
  def change
    change_table :jobs, bulk: true do |t|
      t.column :men_workforces, :integer, default: nil
      t.column :women_workforces, :integer, default: nil
    end
  end
end
