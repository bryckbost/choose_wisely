ChooseWisely::Application.routes.draw do
  resources :decisions, :only => [:show, :create, :update]

  root :to => "decisions#new"
end
