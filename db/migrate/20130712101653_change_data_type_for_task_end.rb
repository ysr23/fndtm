class ChangeDataTypeForTaskEnd < ActiveRecord::Migration
  def up
    change_column :tasks, :task_end, :datetime     
  end

  def down
  end
end
