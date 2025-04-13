class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to current_user.role == "admin" ? admin_dashboard_path : dashboard_path, notice: 'Logged in successfully.'
        else
            flash.now[:alert] = "Invalid username or password."
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path, notice: "Logged out."
    end
end
