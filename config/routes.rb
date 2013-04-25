WageCalculation::Application.routes.draw do
  root :controller => "welcome", :action => "index"

  match 'account_journal' => 'account_journal#index', :as => :account_journal
  match 'account_journal/report_time_sheet' => 'account_journal#report_time_sheet', :as => :report_time_sheet
  match 'help' => 'help#index', :as => :app_help

  #routes for choosing
    match 'chooses/workers' => 'chooses#workers', :as => :chooses_worker
    match 'chooses/shedule_of_workers' => 'chooses#shedule_of_workers', :as => :chooses_shedule
    match 'chooses/absences' => 'chooses#absences', :as => :chooses_absences
  #=============routes for choosing

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end
  resources :schedule_of_workings do
    match :filling, :via => [:get, :post], :on => :collection
  end
  resources :sch_of_work_informations

  namespace :reference do
    resources :workers
    resources :absences
    resources :departments
    resources :positions
  end
  
  namespace :information do
    resources :time_sheets do
      match :filling, :via => :post, :on => :collection
    end
    resources :workers
  end

  resources :charges do
    match :filling, :via => :post, :on => :collection
  end

  resources :deductions do
    match :filling, :via => :post, :on => :collection
  end

  resources :deductions do 
    match :filling, :via => :post, :on => :collection
  end

  namespace :app_parameters do
    match :account_period, :via => [:get, :put]
  end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
