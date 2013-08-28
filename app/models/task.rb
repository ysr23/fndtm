class Task < ActiveRecord::Base
  attr_accessible :name, :dev_notes, :notes, :task_end, :task_start, :task_type, :completed, :completed_at
  validates :user_id, :name, presence: true
  belongs_to :user
#  before_create :set_times

  def self.tasks_for_day(day)
    @uncompleted_tasks = @tasks.select { |task| not task.completed?}
    # to_date required below due to: 
    # http://stackoverflow.com/questions/12811207/comparison-of-date-with-activesupporttimewithzone-failed
    @uncompleted_tasks = @uncompleted_tasks.select { |task| task.task_start.to_date <= day if task.task_start} 
    #@uncompleted_tasks.sort_by{|e| e[:task_start] }  
    @overdue = @uncompleted_tasks.select { |task| task.task_start < Date.today }
  end

  def self.parse_time(ivh)
    if ivh.has_key?("start_time")
      ivh["start_time"] = ivh.fetch("start_time").instance_variable_get("@time") 
      hr = ivh["start_time"][0,2]
      min = ivh["start_time"][2,2]
      sec = ivh["start_time"][4,2]
      ivh["start_time"] = "#{hr}:#{min}:#{sec}"
    end
  end

  def tasks_by_day
  @tasks = @tasks.select { |task| task.task_start <= Date.today if task.task_start} 
  end

  def self.inst_var(nickel_array)
    puts "working:..."
    inst_var_results = [] 
    nickel_array.instance_variables.each { |inst_var| inst_var_results << inst_var.to_s.sub!('@','') }
    ivh = {} 
    inst_var_results.each {|x| ivh["#{x}"] = nickel_array.instance_variable_get("@#{x}")
    }
    if ivh.has_key?("start_date")
      ivh["start_date"] = ivh.fetch("start_date").instance_variable_get("@date") 
      parse_time(ivh)
      ivh["start_date"] = "#{ivh['start_date']} #{ivh['start_time']}"
      #ivh["start_date"] = "#{ivh['start_date']}"
    else
      parse_time(ivh)  
    end 
    ivh
  end
end
