# frozen_string_literal: true

class CreateTaskTags < ActiveRecord::Migration[7.0]
  def change
    create_table :task_tags do |t|
      t.integer :task_id
      t.integer :tag_id

      t.timestamps
    end

    add_index :task_tags, :task_id
    add_index :task_tags, :tag_id
  end
end
