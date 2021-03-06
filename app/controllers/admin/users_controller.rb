class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
  end

  def create
    generated_password = Devise.friendly_token.first(8)
    user = User.new(user_params.merge(password: generated_password))
    if user.save
      user.send_reset_password_instructions # TODO: customize this!
      flash[:notice] = "We've sent an email to #{user.email} with login instructions."
    else
      flash[:error] = user.errors.full_messages.first
    end
    redirect_to action: :index
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    flash[:notice] = "#{user.email} can no longer login."
    redirect_to action: :index
  end

private

  def user_params
    params.require(:user).permit(:email)
  end

end
