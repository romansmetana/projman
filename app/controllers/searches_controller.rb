# frozen_string_literal: true

class SearchesController < ApplicationController
  def search
    if params[:title] == ''
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('search_results', partial: 'searches/results_not_found')
        end
      end
    else
      @search = current_user.projects.where('title ILIKE ?', "%#{params[:title]}%")
      @search += current_user.tasks.where('title ILIKE ?', "%#{params[:title]}%")
      @search += current_user.tags.where('title ILIKE ?', "%#{params[:title]}%")
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('search_results', partial: 'searches/search_results',
                                                                     locals: { search_results: @search })
        end
      end
    end
  end
end
