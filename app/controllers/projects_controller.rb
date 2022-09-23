# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  def index
    @pagy, @projects = pagy(current_user.projects.order('position DESC'))
  end

  def show; end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    @project.set_position
    respond_to do |format|
      if @project.save
        flash[:success] = t('controllers.project.success.create')
        format.turbo_stream
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@project)}_form", partial: 'form',
                                                                                        locals: { project: @project })
        end
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @project.update(project_params)
        flash[:success] = t('controllers.project.success.update')
        format.turbo_stream
        format.html { redirect_to root_path }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@project)}_form", partial: 'form',
                                                                                        locals: { project: @project })
        end
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      flash[:success] = t('controllers.project.success.destroy')
      format.turbo_stream
    end
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :position)
  end
end
