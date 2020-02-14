class UsersController <ApplicationController

  def edit

  end

  def update
      if current_user
        current_user.update(users_params)
        flash[:notice] = "Update succesful!"
      end
      redirect_to "/users/about_me"
  end

  def about_me
    @user = current_user
  end


  private
    def users_params
        params.require(:user).permit(:nickname, :quote, :aboutme, :image, :name)
    end
end
