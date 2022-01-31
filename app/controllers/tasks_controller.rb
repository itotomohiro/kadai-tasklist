class TasksController < ApplicationController
  
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    unless logged_in?
      redirect_to login_url
    end
#    @tasks = current_user.tasks.all
    @tasks = Task.all
#    @tasks = Task.where(user_id: @user.id)
  end
  
  def show
    unless my_task?
      redirect_to login_url
    end
    @task = Task.find(params[:id])
  end

  def new
#    @task = Task.new
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
    unless my_task?
      redirect_to login_url
    end
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'Taskが正常に更新されました' 
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
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
  
end
