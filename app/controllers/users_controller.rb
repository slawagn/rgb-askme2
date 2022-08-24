class UsersController < ApplicationController
  before_action :find_user_by_nickname, only: %i[show edit update destroy]
  before_action :authorize_owner, only: %i[edit update destroy]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in_as(@user)
      redirect_to root_path, notice: 'Вы успешно зарегистрировались!'
    else
      flash.now[:alert] = 'Что-то пошло не так!'
      render :new
    end
  end

  def show
    @questions = @user.questions_received.latest
    @question  = Question.new(user: @user)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Данные пользователя обновлены'
    else
      flash.now[:alert] = 'При попытке сохранить пользователя возникли ошибки'

      render :edit
    end
  end

  def destroy
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь удалён'
  end

  private

  def user_params
    params
      .require(:user)
      .permit(
        :name,
        :nickname,
        :email,
        :password,
        :password_confirmation,
        :header_color
      )
  end

  def find_user_by_nickname
    @user = User.find_by(nickname: params[:nickname])
  end

  def authorize_owner
    redirect_forbidden unless current_user == @user
  end
end
