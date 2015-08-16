class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def update
    if current_user.update_attributes(twitter: params[:user][:twitter])
      redirect_to user_path(current_user)
    end
  end
end
