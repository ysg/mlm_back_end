# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Identity.delete_all

def set_user_attributes_in_identity(user_name)
  user_attributes = {}
  user_attributes[:street_address] = user_name+" street"
  user_attributes[:city] = user_name+" city"
  user_attributes[:state] = user_name+" state"
  user_attributes[:zip] = user_name+" zip"
  user_attributes[:home_phone] = "1111111"
  user_attributes[:cell] = "1111111111"
  user_attributes[:package] = "1"
  user_attributes[:referer_id] = "123456"
  user_attributes
end
def set_user_attributes_from_name(user)
  accessible_attributes = User.accessible_attributes.to_a
  accessible_attributes.shift()
  accessible_attributes.each do |attr|
    user.send(attr+"=","#{user.name} #{attr.to_s}") unless attr == "home_phone" || attr == "cell"
    user.send(attr+"=","1111111") if attr == "home_phone"
    user.send(attr+"=","1111111111") if attr == "cell"
  end
end



root = User.new

root.name = 'root'
root.email ="root@root.com"
root.company="root company"
root.street_address="root street"
root.city="root city"
root.state="root state"
root.zip="root zip"
root.home_phone="1111111"
root.package="1"
root.cell='123123123'
root.referer_id = 123456
root.save

id_andy = Identity.create(
    {:name => 'Andy Bas', :email => 'andyjbas@gmail.com', :password => 'pppppppp', :password_confirmation => 'pppppppp'}
    .merge(set_user_attributes_in_identity("andy"))
)

andy = root.children.create
andy.uid = id_andy.id
andy.provider = "identity"
andy.name = "Andy Bas"
andy.email = "andyjbas@gmail.com"
andy.package = "1"
andy.referer_id = "223456"
andy.home_phone="1111111111"
andy.cell="1111111111"
set_user_attributes_from_name(andy)
andy.save


id_steve = Identity.create(
    {:name => 'Steve Livneh', :email => 'slivneh@yahoo.com', :password => 'pppppppp', :password_confirmation => 'pppppppp'}
    .merge(set_user_attributes_in_identity("steve"))
)

steve = root.children.create
steve.uid = id_steve.id
steve.provider = "identity"
steve.name = "Steve Livneh"
steve.email = "slivneh@yahoo.com"
steve.package = "1"
steve.home_phone = "1111111111"
steve.cell = "1111111111"
steve.referer_id = "223456"
set_user_attributes_from_name(steve)
steve.save

id_deb = Identity.create(
    {:name => 'Deborah Glass', :email => 'deborahglass77@gmail.com', :password => 'pppppppp', :password_confirmation => 'pppppppp'}
    .merge(set_user_attributes_in_identity("deb"))
)

deb = root.children.create
deb.uid = id_deb.id
deb.provider = "identity"
deb.name = "Deborah Glass"
deb.email = "deborahglass77@gmail.com"
deb.package = "1"
deb.home_phone = "1111111111"
deb.cell = "111111111"
deb.referer_id = "323456"
set_user_attributes_from_name(deb)
deb.save

id_alex = Identity.create(
    {:name => 'Alex Dong', :email => 'alexdongqian@yahoo.com', :password => 'pppppppp', :password_confirmation => 'pppppppp'}
    .merge(set_user_attributes_in_identity("alex"))
)

alex = root.children.create
alex.uid = id_alex.id
alex.provider = "identity"
alex.name = "Steve Livneh"
alex.email = "slivneh@yahoo.com"
alex.package = "1"
alex.home_phone = "1111111111"
alex.cell = "1111111111"
alex.referer_id = "423456"
set_user_attributes_from_name(alex)
alex.save

