Rails.application.routes.draw do

  devise_for :users, controllers: {sessions: 'users/sessions', confirmations: 'users/confirmations', registrations: 'users/registrations'}

  as :user do
    get 'magic/:key', to: 'users/sessions#magic_login'
  end

  match '/vouchers/:id/capture' => 'vouchers#capture', via: [:get, :post], as: :capture_voucher
  match '/vouchers/:id/schedule' => 'vouchers#schedule', via: [:get, :post], as: :schedule_voucher
  match '/vouchers/:id/schedule/success' => 'vouchers#success_schedule', via: [:get, :post], as: :success_schedule_voucher

  match '/api/documentation' => 'api_accesses#documentation', via: [:get, :post], as: :api_documentation

  resources :vouchers
  resources :designs
  resources :api_accesses, :path => 'api'

  mount API::Base, at: "/"

  root :to => "statics#landing"
end
