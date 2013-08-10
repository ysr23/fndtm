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
    end
  end
  def newxx
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = current_user.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @task.user_id = current_user.id
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
    redirect_to :action => "index" 
  end

  def set_uncomplete
    @task = current_user.tasks.find(params[:id])
    @task.update_attributes(:completed_at => nil, :completed => false)
    redirect_to :action => "index" 
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
    #@completed_tasks_for_day = @tasks.select {|task| task.completed? where task_completed_at.to_date == day
    @completed_tasks = @tasks.select { |task| task.completed?}
    @uncompleted_tasks = @tasks.select { |task| not task.completed?}
    @uncompleted_tasks = @uncompleted_tasks.select { |task| 
      if day == Date.today
        task.task_start.to_date <= day if task.task_start
      else 
        task.task_start.to_date == day if task.task_start
      end
    } 
    # to_date required below due to: 
    # http://stackoverflow.com/questions/12811207/comparison-of-date-with-activesupporttimewithzone-failed
    @completed_tasks_for_day = @completed_tasks.select { |task| 
      task.completed_at.to_date == day if task.completed_at
    }
    @overdue = @uncompleted_tasks.select { |task| task.task_start.to_date < Date.today if task.task_start }
    @completed_tasks_for_day.sort_by! &:task_start
    @uncompleted_tasks.sort_by! &:task_start
    @all_tasks = (@uncompleted_tasks + @completed_tasks_for_day)
  end
end
