class ChangeTaskStartAndTaskEndInTask < ActiveRecord::Migration
  def up
    change_column :tasks, :task_start, :date
    change_column :tasks, :task_end, :date
    add_column :tasks, :task_start_time, :time
    add_column :tasks, :task_end_time, :time
  end

  def down
    change_column :tasks, :task_start, :datetime
    change_column :tasks, :task_end, :date
    remove_column :tasks, :task_start_time, :time
    remove_column :tasks, :task_end_time, :time
  end
end
