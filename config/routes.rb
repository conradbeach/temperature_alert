# frozen_string_literal: true

Rails.application.routes.draw do
  root "pages#home"

  get "dashboard", to: "users#show"
end
