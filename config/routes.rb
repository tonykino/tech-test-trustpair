# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  root 'jobs#index'
  post 'import_jobs', to: 'jobs#import'
end
