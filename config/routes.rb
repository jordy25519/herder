Rails.application.routes.draw do
    root 'test#index'
    get 'test/index', to: 'test#index'
    get 'test/io_rate', to: 'test#io_rate'
end
