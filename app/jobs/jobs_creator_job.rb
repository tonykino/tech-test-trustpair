# frozen_string_literal: true

class JobsCreatorJob < ApplicationJob
  queue_as :default

  def perform(row)
    Job.create_and_complete(
      year: row['Année'],
      contract_type: row['Type de contrat'],
      job: row['Emplois']
    )
  end
end
