class AddUserIdToTags < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :user, index: true
  end
end
