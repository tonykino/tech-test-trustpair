# frozen_string_literal: true

require 'csv'

class JobsImporter
  def self.create_jobs_from_csv(file_path)
    CSV.foreach(file_path, headers: true, col_sep: ';') do |row|
      JobsCreatorJob.perform_later(row.to_hash)
    end
  end
end
