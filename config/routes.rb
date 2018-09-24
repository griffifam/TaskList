Rails.application.routes.draw do
  root 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  #all_tasks_path
  get '/tasks', to: 'tasks#index', as: 'all_tasks'

  #new_task_path
  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post "/tasks", to: "tasks#create"

  # #edit_task_path
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  patch '/tasks/:id', to: 'tasks#update'

  patch '/tasks/:id/complete', to: 'tasks#complete', as: 'complete'

  delete '/tasks/:id', to: 'tasks#destroy'

  #task_path
    get '/tasks/:id', to: 'tasks#show', as: 'task'
end
