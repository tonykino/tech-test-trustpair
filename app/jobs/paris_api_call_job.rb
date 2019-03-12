# frozen_string_literal: true

class ParisApiCallJob < ApplicationJob
  queue_as :default

  def perform(job)
    job.complete_with_workforces_from_api_data
  end
end
