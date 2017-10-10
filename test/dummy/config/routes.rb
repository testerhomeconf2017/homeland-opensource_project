Rails.application.routes.draw do
  mount Homeland::OpensourceProject::Engine => "/homeland-opensource_project"
end
