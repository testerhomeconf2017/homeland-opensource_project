Homeland::OpensourceProject::Engine.routes.draw do
  resources :opensource_projects do
    collection do
      get :upcoming
      post :preview
    end
    member do
      put :publish
    end
  end
  namespace :admin do
    resources :opensource_projects
  end
end
