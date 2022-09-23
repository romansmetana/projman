# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def sortable_link(column)
    direction = if params[:direction] == 'ASC'
                  'DESC'
                else
                  'ASC'
                end
    link_to direction == 'ASC' ? title ||= 'nejnovější'.titleize : 'nejstarší'.titleize, sort: column,
                                                                                         direction: direction
  end
end
