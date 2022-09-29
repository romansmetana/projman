# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[download_file show edit update destroy]

  def index
    @pagy, @tasks = pagy(Task.filter(params, current_user))
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    respond_to do |format|
      if @task.save
        flash[:success] = t('controllers.task.success.create')
        format.turbo_stream
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@task)}_form", partial: 'form',
                                                                                     locals: { task: @task })
        end
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @task.update(task_params)
        flash[:success] = t('controllers.task.success.update')
        format.turbo_stream
        format.html { redirect_to root_path }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@task)}_form", partial: 'form',
                                                                                     locals: { task: @task })
        end
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      flash[:success] = t('controllers.task.success.destroy')
      format.turbo_stream
    end
  end

  def download_file
    send_file @task.file.path,
          :filename => @task.file_identifier,
          :type => @task.file.content_type,
          :x_sendfile => true,
          :disposition => 'attachment'
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id] || params[:task_id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :is_done, :file, :project_id, tag_ids: [])
  end
end
