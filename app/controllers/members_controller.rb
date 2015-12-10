class MembersController < ApplicationController
  load_and_authorize_resource
  
  def create
    if @member.save
      log_in @member
      flash[:success] = "Congratulations, #{@member.login}! 
                                    You signed up successfully!"
      redirect_to root_url
    else
      flash.now[:danger] = "Something went wrong. Try again, please."
      render 'new'
    end
  end

  def show
    @ads = @member.ads
  end

  def update
    if @member.update_attributes(member_params)
      flash[:success] = "Profile updated"
      redirect_to member_url
    else
      render 'edit'
    end
  end

  def destroy
    @member.destroy
    flash[:info] = "Member deleted"
    redirect_to root_url
  end

  private

    def member_params
      params.require(:member).permit(:login, :full_name, :birthday, :email, 
                                                        :address, :city, :state, :country, :zip, 
                                                        :password, :password_confirmation, :role)
    end
    
end
