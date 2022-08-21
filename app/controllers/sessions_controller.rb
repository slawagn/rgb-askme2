class SessionsController < ApplicationController
  def new
  end

  def create
    user_params = params.require(:session)

    user = 
      find_and_authenticate(
        email:    user_params[:email],
        password: user_params[:password]
      ) 

    if user.present?
      log_in_as(user)

      redirect_to root_path, notice: 'Вы вошли на сайт'
    else
      flash.now[:alert] = 'Неправильный email или пароль'

      render :new
    end
  end

  def destroy
    session.delete(:user_id)

    redirect_to root_path, notice: 'Вы вышли из аккаунта'
  end

  private

  def find_and_authenticate(email:, password:)
    email.downcase!

    User.find_by(email: email)&.authenticate(password)
  end
end
