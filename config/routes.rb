Rails.application.routes.draw do
	root to: 'home#index'

  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
