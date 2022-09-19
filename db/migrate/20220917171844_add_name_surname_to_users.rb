# frozen_string_literal: true

class AddNameSurnameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, null: false, default: ''
    add_column :users, :surname, :string, null: false, default: ''
  end
end
