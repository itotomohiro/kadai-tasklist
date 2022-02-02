class TasksController < ApplicationController
  
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :not_login_redirect, only: [:index, :show, :edit]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end
  
  def show
  end

  def new
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Taskが正常に投稿されました' 
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Taskが正常に更新されました' 
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'Taskが正常に削除されました' 
    redirect_to tasks_url
  end

  
  private

  def task_params
    params.require(:task).permit(:content)
  end
  
  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def not_login_redirect
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end
