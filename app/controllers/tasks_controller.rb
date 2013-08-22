class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json

  def index
    if params[:on].present? 
       @day_to_view = params[:on].to_date 
     else
       @day_to_view = Date.today
    end
    @tasks = current_user.tasks
#    @upcoming_tasks = @tasks.select { |task| task.task_start.to_date > Date.today if task.task_start}
 #   @completed_tasks = @tasks.select { |task| task.completed?}
    tasks_for_day(@day_to_view) if @day_to_view
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end
  
  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = current_user.tasks.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
      format.js
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = current_user.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @day_to_view = params[:task][:date_from_params] 
    params[:task].delete :date_from_params
    @task = Task.new(params[:task])
    @task.user_id = current_user.id
    @task.task_start = @day_to_view
    set_times
    respond_to do |format|
      if @task.save
        format.html { flash[:notice] = 'Task was successfully created' and redirect_to action: "index" }
        format.json { render json: @task, status: :created, location: @tasks }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_complete
    @task = current_user.tasks.find(params[:id])
    @task.update_attributes(:completed_at => Time.now, :completed => true)
    respond_to do |format| 
      format.html { redirect_to :action => "index" }
      format.js 
    end
  end

  def set_uncomplete
    @task = current_user.tasks.find(params[:id])
    @task.update_attributes(:completed_at => nil, :completed => false)
    respond_to do |format| 
      format.html { redirect_to :action => "index" }
      format.js 
    end
 end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = current_user.tasks.find(params[:id])
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to '/tasks/', notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
      format.js
    end
  end

  def tasks_for_day(day)
    @upcoming_tasks = @tasks.select { |task| task.task_start.to_date > Date.today if task.task_start}
    @completed_tasks = @tasks.select { |task| task.completed?}
    @uncompleted_tasks = @tasks.select { |task| not task.completed?}
    @uncompleted_tasks = @uncompleted_tasks.select { |task| 
      if day == Date.today
        task.task_start.to_date <= day if task.task_start
      else 
        task.task_start.to_date == day if task.task_start
      end
    } 
    @completed_tasks_for_day = @completed_tasks.select { |task| 
      task.completed_at.to_date == day if task.completed_at
    }
    @overdue = @uncompleted_tasks.select { |task| task.task_start.to_date < Date.today if task.task_start }
    @completed_tasks_for_day.sort_by! &:task_start
    @uncompleted_tasks.sort_by! &:task_start
    @all_tasks = (@uncompleted_tasks + @completed_tasks_for_day)
  end

  def set_times
    if @task.name
      nickel = Nickel.parse(@task.name)
      @task.dev_notes = "Original Message was: '#{@task.name}' "
      @task.name = nickel.message
      inst_vars = Task.inst_var(nickel.occurrences[0], @day_to_view)
      @task.dev_notes << " #{inst_vars}"
      @task.task_start = "#{inst_vars["start_date"]}".to_datetime
    else
      @task.dev_notes = "Something has gone very wrong indeed!"
    end 
  end 


end
