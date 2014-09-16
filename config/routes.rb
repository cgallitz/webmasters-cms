WebmastersCms::Engine.routes.draw do
    namespace :admin do
      resources :pages do
        member do
          patch :set_current_version
        end

        collection do
          put :sort
        end
        resources :page_translations, path: :translations, as: :translations, only: [:destroy]
        resources :page_translation_versions, path: :versions, as: :versions, only: [:index, :show]

      end
      resources :active_languages, only: [:index, :new, :create, :destroy]
    end

    resources :pages, only: [] do
      collection do
        match :preview, via: [:post, :patch]
      end
    end

    root :to => 'pages#index'
end
