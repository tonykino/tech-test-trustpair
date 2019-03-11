# frozen_string_literal: true

class JobsController < ApplicationController
  def index
    @jobs = Job.all.order(:job).order(:year)
  end

  def import
    JobsImporter.create_jobs_from_csv(params[:jobs_list].path)
    redirect_to root_path, notice: 'Le fichier a bien été importé'
  end
end
