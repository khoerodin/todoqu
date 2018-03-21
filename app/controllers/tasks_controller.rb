class TasksController < ApplicationController
  def index
    @dues = dues 
    @tasks = tasks
  end

  def filter
    filter = params[:filter]
    sort = params[:sort]

    # show / filter by
    if filter == 'today'
      tasks = mine.where(due: Date.today)
    elsif filter == 'queue'
      tasks = mine.where('DATE(due) > ?', Date.today).where(completed: false)
    elsif filter == 'completed'
      tasks = mine.where(completed: true)
    else
      tasks = mine
    end

    # sorted by
    @tasks = tasks.order(sort == 'created_at' ? sort + " DESC" : sort)

    render partial: 'tasks', locals: { tasks: @tasks }, layout: false 
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
      render 'new'
    end
  end

  def edit
    @task = mine.find(params[:id])
  end

  def update
    @task = mine.find(params[:id])

    if @task.update(task_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def due
    @dues = dues
    render partial: 'dues', locals: { dues: @dues }, layout: false
  end

  def all
    @tasks = tasks
    render partial: 'tasks', locals: { tasks: @tasks }, layout: false
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

    def mine
      Task.where(user_id: current_user[:id])
    end

    def task_params
      params.require(:task).permit(:name, :priority, :due, :completed)
    end

    def dues
      mine.where(due: Date.today)
        .where(completed: false)
    end

    def tasks
      mine.order('created_at DESC')
    end
end
