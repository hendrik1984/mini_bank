class DashboardController < ApplicationController
  before_action :require_login
  
  def index
    if current_user.role == 'admin'
      @users = User.all
    end

    @user = current_user
    @transactions = Transaction.where("user_id = ? OR recipient_id = ?", current_user.id, current_user.id).order(created_at: :desc).limit(20)
  end
end
