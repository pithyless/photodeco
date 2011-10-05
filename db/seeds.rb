
u = User.new   :first_name => 'Norbert',
               :last_name => 'Wojtowicz',
               :email => 'a@b.com',
               :password => 'secret',
               :password_confirmation => 'secret'
u.role = 'admin'
u.save! unless User.first

p = Provider.new
p.slug = 'agencja-forum'
p.name = 'Agencja Forum'
p.save!

s = Store.new
s.name = 'Photodeco'
s.slug = 'photodeco'
s.domain = 'photodeco.pl'
