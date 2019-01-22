Rails.application.routes.draw do

  devise_for :users, controllers: {sessions: 'users/sessions', confirmations: 'users/confirmations'}

  resources :vouchers
  resources :designs

  root :to => "statics#landing"
end
