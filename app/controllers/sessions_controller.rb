class SessionsController < ApplicationController

  def create
    if (auth = request.env['omniauth.auth'])
      member = Member.find_member_with_omniauth(auth)
      create_new_session(member)
    elsif (member = Member.find_by(login: params[:session][:login]))
      if member && member.authenticate(params[:session][:password])
        create_new_session(member) do
          params[:session][:remember_me] == '1' ? remember(member) : forget(member)  
        end
      else
        flash.now[:danger] = "Invalid login/password information."
        render 'new'
      end
    else
      flash.now[:danger] = "Invalid login/password information."
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

    def create_new_session(member)
      flash[:success] = "You logged in successfully! Welcome, #{member.login}!"
      log_in member
      yield if block_given? 
      redirect_to root_url
    end

end
