class AddIndexToTasks < ActiveRecord::Migration
  def change
    add_index :tasks, [:user_id, :created_at]
  end
end
