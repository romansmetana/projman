class SearchesController < ApplicationController
  def search
    if params[:title] != ""
      @search = current_user.projects.where('title ILIKE ?', "%#{params[:title]}%")
      @search += current_user.tasks.where('title ILIKE ?', "%#{params[:title]}%")
      @search += current_user.tags.where('title ILIKE ?', "%#{params[:title]}%")
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("search_results", partial: "searches/search_results",locals: { search_results: @search} )
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("search_results", Time.zone.now )
        end
      end
    end
  end
end
