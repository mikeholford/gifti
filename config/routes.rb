Rails.application.routes.draw do

  devise_for :users
  resources :vouchers
  resources :designs

  root :to => "statics#landing"
end
