class ChangeDefaultValueToProjects < ActiveRecord::Migration[7.0]
  def change
    change_column_default :projects, :position, 0 
  end
end
