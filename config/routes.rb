Rails.application.routes.draw do

root 'pages#about'
get 'sign-up', to: 'students#new'
get 'login', to: 'sessions#new'
post 'login', to: 'sessions#create'
delete 'logout', to: 'sessions#destroy'

resources :courses
resources :students

post 'course_enroll', to: 'student_courses#create'
delete 'course_unenroll', to: 'stduetn_courses#destroy'

end
