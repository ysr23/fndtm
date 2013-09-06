class UsersController <ApplicationController
  #users_controller.rb
  def show
    @user = User.find(params[:id])
  end
end

