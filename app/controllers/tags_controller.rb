# frozen_string_literal: true

class TagsController < ApplicationController
  rescue_from ActionController::MissingExactTemplate, with: :catch_error
  before_action :set_tag, only: %i[show edit update destroy]

  def index
    @pagy, @tags = pagy(current_user.tags)
  end

  def show; end

  def new; end

  def create
    @tag = current_user.tags.build(tag_params)
    respond_to do |format|
      if @tag.save
        flash[:success] = t('controllers.tag.success.create')
        format.turbo_stream
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@tag)}_form", partial: 'form',
                                                                                    locals: { tag: @tag })
        end
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        flash[:success] = t('controllers.tag.success.update')
        format.turbo_stream
        format.html { redirect_to root_path }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@tag)}_form", partial: 'form',
                                                                                    locals: { tag: @tag })
        end
      end
    end
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      flash[:success] = t('controllers.tag.success.destroy')
      format.turbo_stream
    end
  end

  private

  def set_tag
    @tag = current_user.tags.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:title, :taks_id)
  end

  def catch_error
    redirect_to root_path
  end
end
