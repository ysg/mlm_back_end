# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all

root = User.create
root.name = 'root'
root.package = 1
root.referer_id = 123456
#root.password = 'holanda'
#root.password_confirmation = 'holanda'
root.save


andy = root.children.create
andy.name = 'Andy'
andy.email = 'andy@bpb.com'
#andy.password = 'holanda'
#andy.password_confirmation = 'holanda'
andy.package = 1
andy.referer_id = 654321
andy.save

ysg = andy.children.create 
ysg.name = 'Jayandra'
ysg.email = 'jayandra@bpb.com'
ysg.package = 1
ysg.referer_id = 123654
#ysg.password = 'holanda'
#ysg.password_confirmation = 'holanda'
ysg.save

ah = andy.children.create 
#ah.password = 'holanda'
#ah.password_confirmation = 'holanda'
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
#juan.password = 'holanda'
#juan.password_confirmation = 'holanda'
juan.save

emi = ysg.children.create 
emi.name = 'Emiliano Garcia', 
emi.email = 'emiliano@bpb.com', 
emi.package = 2
#emi.password = 'holanda'
#emi.password_confirmation = 'holanda'
emi.referer_id = 999999
emi.save

remer = ysg.children.create
remer.name = 'Miguel Revetria'
remer.email = 'remer@bpb.com'
remer.package = 3
remer.referer_id = 111111
#remer.password = 'holanda'
#remer.password_confirmation = 'holanda'
remer.save
#users = 
#	User.create([{ name: 'Agustin', email: 'agustinh17@gmail.com', parent_id: root.id}, { name: 'Andy', email: 'andyjbas@gmail.com', parent_id: root.id} ])
