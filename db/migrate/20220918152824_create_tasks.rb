# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false, default: ''
      t.text :description
      t.boolean :is_done, null: false, default: false
      t.string :file

      t.timestamps
    end
  end
end
