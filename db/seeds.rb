
u = User.new   :first_name => 'Norbert',
               :last_name => 'Wojtowicz',
               :email => 'a@b.com',
               :password => 'secret',
               :password_confirmation => 'secret'
u.role = 'admin'
u.save!
