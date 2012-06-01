# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Identity.delete_all

root = User.create
root.name = 'root'
root.package = 1
root.referer_id = 123456
#root.password = 'holanda'
#root.password_confirmation = 'holanda'
root.save

id_andy = Identity.create :name => 'Andy', :email => 'andy@bpb.com', :password => 'holanda', :password_confirmation => 'holanda'

andy = root.children.create
andy.name = 'Andy'
andy.email = 'andy@bpb.com'
andy.package = 1
andy.referer_id = 654321
andy.provider = 'identity'
andy.uid = id_andy.id
andy.save

id_ysg = Identity.create :name => 'Jayandra', :email => 'jayandra@bpb.com', :password => 'holanda', :password_confirmation => 'holanda'

ysg = andy.children.create 
ysg.name = 'Jayandra'
ysg.email = 'jayandra@bpb.com'
ysg.package = 1
ysg.referer_id = 123654
ysg.provider = 'identity'
ysg.uid = id_ysg.id
ysg.save

ah = andy.children.create
ah.name = 'Agustin Hernandez'
ah.email = 'agustin@bpb.com'
ah.package = 2
ah.referer_id = 654123
ah.save

juan = ysg.children.create
juan.name = 'Juan Pequenio'
juan.email = 'juan@bpb.com'
juan.package = 1
juan.referer_id = 666666
juan.save

emi = ysg.children.create 
emi.name = 'Emiliano Garcia', 
emi.email = 'emiliano@bpb.com', 
emi.package = 2
emi.referer_id = 999999
emi.save

remer = ysg.children.create
remer.name = 'Miguel Revetria'
remer.email = 'remer@bpb.com'
remer.package = 3
remer.referer_id = 111111
remer.save

