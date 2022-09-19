# frozen_string_literal: true

class ProjectsController < ApplicationController
  def index
    @projects = current_user.projects.all
  end

  def show; end

  def edit; end

  def new; end

  def create
    @project = current_user.projects.build(project_params)
    respond_to do |format|
      if @project.save
        format.turbo_stream
      else

      end
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def project_params
    params.require(:project).permit(:title, :position)
  end
end
