# frozen_string_literal: true

Rails.application.routes.draw do
  root 'jobs#index'
  post 'import_jobs', to: 'jobs#import'
end
