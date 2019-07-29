# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller

  private

  def unsafe_params
    params.permit!
  end
end
