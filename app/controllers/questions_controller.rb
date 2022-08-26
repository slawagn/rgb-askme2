class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy hide]
  before_action :authorize_question_owner, only: %i[edit update destroy hide]

  def index
    @questions = Question.latest.first(10)
    @users     = User.latest.first(10)
  end

  def new
    @user = User.find(params[:user_id])
    @question = Question.new(user: @user)
  end

  def create 
    question_params = params.require(:question).permit(:body, :user_id)
    
    @question = Question.new(question_params)

    @question.author = current_user

    if @question.save
      redirect_to user_path(@question.user.nickname), notice: 'Новый вопрос создан!'
    else
      flash.now[:alert] = 'Что-то пошло не так!'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)
    
    @question.update(question_params)

    redirect_to user_path(@question.user.nickname), notice: 'Сохранили вопрос!'
  end

  def destroy
    @user = @question.user
    @question.destroy

    redirect_to user_path(@user.nickname), notice: 'Вопрос удалён!'
  end

  def hide
    @question.update(hidden: true)

    redirect_to questions_path
  end

  private

  def authorize_question_owner
    redirect_forbidden unless @question.user == current_user  
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
