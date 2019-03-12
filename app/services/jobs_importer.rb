# frozen_string_literal: true

require 'csv'

class JobsImporter
  def self.create_jobs_from_csv(file_path)
    CSV.foreach(file_path, headers: true, col_sep: ';') do |row|
      Job.create_and_complete(
        year: row['Année'],
        contract_type: row['Type de contrat'],
        job: row['Emplois']
      )
    end
  end
end
