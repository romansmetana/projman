# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = current_user.tasks.all
  end

  def show; end

  def new; end

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
      format.html { redirect_to root_path }
    end
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :is_done, :project_id)
  end
end
