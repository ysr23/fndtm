class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :task_start
      t.datetime :task_end
      t.string :task_type
      t.text :notes

      t.timestamps
    end
  end
end
