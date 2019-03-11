# frozen_string_literal: true

require 'csv'

class JobsImporter
  def self.create_jobs_from_csv(file_name)
    CSV.foreach(file_name, headers: true, col_sep: ';') do |row|
      Job.create_or_update(
        year: row['Année'],
        collectivity: row['Collectivité'],
        contract_type: row['Type de contrat'],
        job: row['Emplois'],
        level: row['Niveau'],
        specialty: row['Spécialité']
      )
    end
  end
end
