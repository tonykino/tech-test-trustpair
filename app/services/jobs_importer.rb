# frozen_string_literal: true

require 'csv'

class JobsImporter
  def self.create_jobs_from_csv(file_name)
    CSV.foreach(file_name, headers: true, col_sep: ';') do |row|
      Job.create_and_complete(
        year: row['Année'],
        contract_type: row['Type de contrat'],
        job: row['Emplois']
      )
    end
  end
end
