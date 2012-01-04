ChooseWisely::Application.routes.draw do
  resources :decisions, :only => [:show, :create, :update], :path => "/"

  root :to => "decisions#new"
end
