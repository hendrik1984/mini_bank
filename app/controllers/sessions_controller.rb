class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            
            if current_user.role == 'admin'
                redirect_to admin_dashboard_path, notice: 'Logged in successfully'
            elsif current_user.role == 'merchant'
                redirect_to merchant_dashboard_path, notice: 'Logged in successfully as merchant'
            else
                redirect_to dashboard_path, notice: "Logged in successfully"
            end
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
