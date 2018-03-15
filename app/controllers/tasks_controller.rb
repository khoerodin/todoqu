class TasksController < ApplicationController
  def index
    @dues = dues
    @tasks = tasks
  end

  def excel_export
    @tasks = tasks
    respond_to do |format|
      format.xls { set_file_name "export.xls" }
    end
  end

  def sorted_by
    sorted_by = params[:sorted_by]

    if sorted_by == 'last_created'
      @tasks = Task.where(user_id: current_user[:id])
        .order('created_at DESC')
    elsif sorted_by == 'due'
      @tasks = Task.where(user_id: current_user[:id])
        .order('due')
    elsif sorted_by === 'priority'
      @tasks = Task.where(user_id: current_user[:id])
        .order('priority')
    elsif sorted_by === 'name'
      @tasks = Task.where(user_id: current_user[:id])
        .order('name')
    else
      @tasks = Task.where(user_id: current_user[:id])
        .order('created_at DESC')
    end

    render partial: 'all_task', locals: { tasks: @tasks }, layout: false 
  end

  def new
    @task = Task.new
  end

  def create
    @user = User.find(current_user[:id])
    @task = @user.tasks.new(task_params)

    if @task.save 
      redirect_to root_path
    else
      render "new"
    end
  end

  def update
    task = Task.find(params[:id])
    task.completed = params[:completed]
    updated = task.save

    respond_to do |format|
      format.json  { render :json => updated }
    end
  end

  def due
    @dues = dues
    render partial: 'due_task', locals: { dues: @dues }, layout: false
  end

  def all
    @tasks = tasks
    render partial: 'all_task', locals: { tasks: @tasks }, layout: false
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private
    ## white list
    def task_params
      params.require(:task).permit(:name, :priority, :due, :completed)
    end

    def dues
      Task.where(user_id: current_user[:id]).where('DATE(due) = ?', Date.today)
        .where(:completed => false)
    end

    def tasks
      Task.where(user_id: current_user[:id])
        .order('created_at DESC')
    end
end
