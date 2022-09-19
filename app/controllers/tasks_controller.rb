class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.all
  end

  def show
  end

  def new
  end

  def create
    @task = current_user.tasks.build(task_params)
    respond_to do |format|
      if @task.save
        flash[:success] = t("controllers.task.success.create")
        format.turbo_stream 
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@task)}_form", partial: 'form',
                                                                                        locals: { task: @task })
      end
    end
  end
end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :is_done, :project_id)
  end
end
