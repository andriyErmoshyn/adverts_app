class PasswordResetsController < ApplicationController
  before_action :valid_member,     only: [ :edit, :update ]
  before_action :check_expiration, only: [ :edit, :update ]

  def create
    @member = Member.find_by(email: params[:password_reset][:email].downcase)
    if @member
      @member.create_reset_digest
      @member.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end
  
  def update
    if params[:member][:password].empty?
      @member.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @member.update_attributes(member_params)
      log_in @member
      flash[:success] = "Password has been successfully reset."
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

    def valid_member
      @member = Member.find_by(email: params[:email])
      unless (@member && @member.authenticated?(:reset, params[:id]))
        redirect_to new_password_reset_path
      end
    end

    def member_params
      params.require(:member).permit(:password, :password_confirmation)
    end

    def check_expiration
      if @member.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_path
      end
    end
end
