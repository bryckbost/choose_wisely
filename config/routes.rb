ChooseWisely::Application.routes.draw do
  resources :decisions, :only => [:show, :create]

  root :to => "decisions#new"
end
