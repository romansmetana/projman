# frozen_string_literal: true

class ChangeColumnsTypeToTasks < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :user_id, :integer, null: false
    change_column :tasks, :project_id, :integer
  end
end
