# frozen_string_literal: true

class UsersController < Clearance::UsersController
  before_action :require_login

  def show; end
end
