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
root.referer_id = 123456
root.save

id_andy = Identity.create(
    {:name => 'Andy', :email => 'andy@bpb.com', :password => 'holanda', :password_confirmation => 'holanda'}
    .merge(set_user_attributes_in_identity("andy"))
)

andy = root.children.create
andy.uid = id_andy.id
andy.provider = "identity"
andy.name = "Andy"
andy.email = "andy@bpb.com"
andy.package = "1"
andy.referer_id = "1234560"
set_user_attributes_from_name(andy)
andy.save


id_ysg = Identity.create(
    {:name => 'Ysg', :email => 'ysg@bpb.com', :password => 'holanda', :password_confirmation => 'holanda'}
    .merge(set_user_attributes_in_identity("ysg"))
)

ysg = root.children.create
ysg.uid = id_ysg.id
ysg.provider = "identity"
ysg.name = "Ysg"
ysg.email = "ysg@bpb.com"
ysg.package = "1"
ysg.referer_id = "1234561"
set_user_attributes_from_name(ysg)
ysg.save


#id_ah = Identity.create(
#    {:name => 'ah', :email => 'ah@bpb.com', :password => 'holanda', :password_confirmation => 'holanda'}
#    .merge(set_user_attributes_in_identity("ah"))
#)
#
#ah = andy.children.create
#ah.uid = id_ah.id
#ah.provider = "identity"
#ah.name = "ah"
#ah.email = "ah@bpb.com"
#ah.package = "1"
#ah.referer_id = "12345601"
#set_user_attributes_from_name(ah)
#ah.save
#
#
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
