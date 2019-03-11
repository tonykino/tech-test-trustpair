# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :year
      t.string :collectivity
      t.string :contract_type
      t.string :job
      t.string :level
      t.string :specialty

      t.timestamps
    end
  end
end
