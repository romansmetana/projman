class TagsController < ApplicationController
  def index
    @tags = current_user.tags.all
  end

  def new
  end

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

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def tag_params
    params.require(:tag).permit(:title, :taks_id)
  end
end
