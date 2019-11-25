class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = current_user.tasks.recent
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).recent
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task, notice: "Created #{@task.name}"
    else
      render :new
    end
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "Updated #{@task.name}"
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy!
    redirect_to tasks_url, notice: "Deleted #{@task.name}"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
