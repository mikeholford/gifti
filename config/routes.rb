Rails.application.routes.draw do

  devise_for :users, controllers: {sessions: 'users/sessions'}

  resources :vouchers
  resources :designs

  root :to => "statics#landing"
end
