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
steve.referer_id = "323456"
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
deb.referer_id = "423456"
set_user_attributes_from_name(deb)
deb.save

id_alex = Identity.create(
    {:name => 'Steve Livneh', :email => 'alexdongqian@yahoo.com', :password => 'pppppppp', :password_confirmation => 'pppppppp'}
    .merge(set_user_attributes_in_identity("alex"))
)

alex = root.children.create
alex.uid = id_alex.id
alex.provider = "identity"
alex.name = "Steve Livneh"
alex.email = "slivneh@yahoo.com"
alex.package = "1"
alex.referer_id = "523456"
set_user_attributes_from_name(alex)
alex.save


id_ah = Identity.create(
    {:name => 'Random Name', :email => 'ah@bpb.com', :password => 'pppppppp', :password_confirmation => 'pppppppp'}
    .merge(set_user_attributes_in_identity("ah"))
)

ah = andy.children.create
ah.uid = id_ah.id
ah.provider = "identity"
ah.name = "Random Name"
ah.email = "ah@bpb.com"
ah.package = "1"
ah.referer_id = "123457"
set_user_attributes_from_name(ah)
ah.save

id_ah2 = Identity.create(
    {:name => 'Random Name2', :email => 'ah2@bpb.com', :password => 'pppppppp', :password_confirmation => 'pppppppp'}
    .merge(set_user_attributes_in_identity("ah2"))
)

ah2 = andy.children.create
ah2.uid = id_ah2.id
ah2.provider = "identity"
ah2.name = "Random Name2"
ah2.email = "ah2@bpb.com"
ah2.package = "2"
ah2.referer_id = "123458"
set_user_attributes_from_name(ah2)
ah2.save

id_ah3 = Identity.create(
    {:name => 'Random Name', :email => 'ah3@bpb.com', :password => 'pppppppp', :password_confirmation => 'pppppppp'}
    .merge(set_user_attributes_in_identity("ah3"))
)

ah3 = andy.children.create
ah3.uid = id_ah3.id
ah3.provider = "identity"
ah3.name = "Random Name3"
ah3.email = "ah3@bpb.com"
ah3.package = "3"
ah3.referer_id = "123459"
set_user_attributes_from_name(ah3)
ah3.save

id_ah4 = Identity.create(
    {:name => 'Random Name4', :email => 'ah4@bpb.com', :password => 'pppppppp', :password_confirmation => 'pppppppp'}
    .merge(set_user_attributes_in_identity("ah4"))
)

ah4 = andy.children.create
ah4.uid = id_ah4.id
ah4.provider = "identity"
ah4.name = "Random Name"
ah4.email = "ah4@bpb.com"
ah4.package = "1"
ah4.referer_id = "123460"
set_user_attributes_from_name(ah4)
ah4.save

id_oh = Identity.create(
    {:name => 'Jon Random', :email => 'oh@bpb.com', :password => 'pppppppp', :password_confirmation => 'pppppppp'}
    .merge(set_user_attributes_in_identity("oh"))
)

oh = ah4.children.create
oh.uid = id_oh.id
oh.provider = "identity"
oh.name = "Jon Random"
oh.email = "oh@bpb.com"
oh.package = "1"
oh.referer_id = "133460"
set_user_attributes_from_name(oh)
oh.save

id_oh2 = Identity.create(
    {:name => 'Jon Random2', :email => 'oh2@bpb.com', :password => 'pppppppp', :password_confirmation => 'pppppppp'}
    .merge(set_user_attributes_in_identity("oh2"))
)

oh2 = ah4.children.create
oh2.uid = id_oh2.id
oh2.provider = "identity"
oh2.name = "Jon Random2"
oh2.email = "oh2@bpb.com"
oh2.package = "2"
oh2.referer_id = "134460"
set_user_attributes_from_name(oh2)
oh2.save

id_oh3 = Identity.create(
    {:name => 'Jon Random3', :email => 'oh3@bpb.com', :password => 'pppppppp', :password_confirmation => 'pppppppp'}
    .merge(set_user_attributes_in_identity("oh3"))
)

oh3 = ah4.children.create
oh3.uid = id_oh3.id
oh3.provider = "identity"
oh3.name = "Jon Random3"
oh3.email = "oh3@bpb.com"
oh3.package = "3"
oh3.referer_id = "134630"
set_user_attributes_from_name(oh3)
oh3.save
#id_ysgc1 = Identity.create(
#    {:name => 'ysgc1', :email => 'ysgc1@bpb.com', :password => 'holanda', :password_confirmation => 'holanda'}
#    .merge(set_user_attributes_in_identity("ysgc1"))
#)
#
#ysg1 = ysg.children.create
#ysg1.name = "ysgc1"
#ysg1.email = "ysgc1@bpb.com"
#ysg1.package = "1"
#ysg1.referer_id = "12345611"
#set_user_attributes_from_name(ysgc1)
#ysg1.save
#
#
#id_ysgc2 = Identity.create(
#    {:name => 'ysgc2', :email => 'ysgc2@bpb.com', :password => 'holanda', :password_confirmation => 'holanda'}
#    .merge(set_user_attributes_in_identity("ysgc2"))
#)
#
#ysg2 = ysg.children.create
#ysg2.name = "ysgc2"
#ysg2.email = "ysgc2@bpb.com"
#ysg2.package = "2"
#ysg2.referer_id = "12345612"
#set_user_attributes_from_name(ysgc2)
#ysg2.save
#
#id_ysgc3 = Identity.create(
#    {:name => 'ysgc3', :email => 'ysgc3@bpb.com', :password => 'holanda', :password_confirmation => 'holanda'}
#    .merge(set_user_attributes_in_identity("ysgc3"))
#)
#
#ysg3 = ysg.children.create
#ysg3.name = "ysgc3"
#ysg3.email = "ysgc3@bpb.com"
#ysg3.package = "3"
#ysg3.referer_id = "12345613"
#set_user_attributes_from_name(ysgc3)
#ysg3.save
