class ChangeNullValueToTasks < ActiveRecord::Migration[7.0]
  def up
    change_column :tasks, :is_done, :boolean, null: false, default: false
  end
  def down
    change_column :tasks, :is_done, :boolean, null: true, default: false
  end
end
