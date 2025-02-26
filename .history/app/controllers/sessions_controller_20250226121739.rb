class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    user = User.authenticate_by(params.permit(:email_address, :password))
    if user
      session[:user_id] = user.id  
      Rails.logger.debug "Session set for user_id: #{session[:user_id]}"  # Debugging
      redirect_to root_path, notice: "Signed in successfully."
    else
      redirect_to new_session_path, alert: "Invalid email or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
