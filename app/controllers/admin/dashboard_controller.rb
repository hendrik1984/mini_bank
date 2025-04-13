class Admin::DashboardController < ApplicationController
  before_action :require_login
  before_action :require_admin

  def index
    @users = User.all
    @transactions = Transaction.order(created_at: :desc)
  end
end
