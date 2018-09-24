# TASKS = [
#   { task: "task one", info: "mark complete | edit | delete"},
#   { task: "task two", info: "unmark complete | edit | delete"},
#   { task: "task three", info: "mark complete | edit | delete"},
#   { task: "task three", info: "mark complete | edit | delete"}
# ]

class TasksController < ApplicationController
  def index
    @tasks = (Task.all).sort_by do |task|
      task.id
    end
    
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(action: params[:task][:action], description: params[:task][:description], completion_date:  params[:task][:completion_date]) #instantiate a new book

    successful_save = task.save

    if successful_save # save returns true if the database insert succeeds
      redirect_to root_path # go to the index so we can see the book in the list
    else # save failed :(
      render :new # show the new book form view again
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    task = Task.find_by(id: params[:id])

    task.update(task_params)

    is_successful = task.save

    if is_successful # save returns true if the database insert succeeds
      redirect_to tasks_path(task.id) # go to the index so we can see the book in the list
    else # save failed :(
      render :new # show the new book form view again
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])

    task.destroy

    redirect_to tasks_path(task.id)
  end

  def complete
    task = Task.find(params[:id])

    if task.mark_complete == "Mark Complete"
      task.update_attributes(:mark_complete => "Unmark Complete", :completion_date => Date.today)
    else
      task.update_attribute(:mark_complete, "Mark Complete")
    end
     redirect_to tasks_path(task.id)

  end


  private

  def task_params
    return params.require(:task).permit(
      :action,
      :description,
      :completion_date
    )
  end

end
