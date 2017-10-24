Admin.create( email: 'admin@ngocquyhoang.com', password: '123456789', password_confirmation: '123456789' )

User.create( email: 'ngocquyhoang.93@gmail.com', username: 'ngocquyhoang', name: 'Hoang Ngoc Quy', gender: 'male', is_verified: true, password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
User.create( email: 'ngocquyhoang2911@gmail.com', username: 'ngocquyhoang2911', name: 'Hoang Ngoc Quy', gender: 'male', is_verified: false, password: '123456789', password_confirmation: '123456789', confirmed_at: DateTime.now )
