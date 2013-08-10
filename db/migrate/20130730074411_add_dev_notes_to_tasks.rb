class AddDevNotesToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :dev_notes, :text
  end
end
