Rails.application.routes.draw do
    root 'test#index'
    get 'test/index', to: 'test#index'
    post 'test/index', to: 'test#index'
end
