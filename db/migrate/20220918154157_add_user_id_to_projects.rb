# frozen_string_literal: true

class AddUserIdToProjects < ActiveRecord::Migration[7.0]
  def change
    add_reference :projects, :user, null: false, index: true
  end
end
