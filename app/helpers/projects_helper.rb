# frozen_string_literal: true

module ProjectsHelper
    def sortable(column, title = nil)
        direction = if params[:direction] == 'ASC'
                      title ||= "nejnovější".titleize
                      'DESC'
                    else
                        title ||= "nejstarší".titleize
                      'ASC'
                    end
        link_to title, sort: column, direction: direction
      end
end
