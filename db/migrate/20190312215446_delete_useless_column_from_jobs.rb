# frozen_string_literal: true

class DeleteUselessColumnFromJobs < ActiveRecord::Migration[5.2]
  def up
    change_table :jobs, bulk: true do |t|
      t.remove :level
      t.remove :specialty
      t.remove :collectivity
    end
  end

  def down
    change_table :jobs, bulk: true do |t|
      t.column :level, :string
      t.column :specialty, :string
      t.column :collectivity, :string
    end
  end
end
