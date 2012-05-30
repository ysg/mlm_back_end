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
root.save

ch1 = root.children.create
ch1.name = 'child 1'
ch1.email = 'child1@mlm.com'
ch1.package = 1
ch1.save

ch2 = root.children.create 
ch2.name = 'child 2'
ch2.email = 'child2@mlm.com'
ch2.package = 1
ch2.save

ch3 = root.children.create
ch3.name = 'child 3'
ch3.email = 'child3@mlm.com'
ch3.package = 2
ch3.save

sch1 = ch1.children.create
sch1.name = 'subch 1.1'
sch1.email = 'subchild_1_1@mlm.com'
sch1.package = 1
sch1.save

sch2 = ch2.children.create 
sch2.name = 'subch 2.1', 
sch2.email = 'subchild_2_1@mlm.com', 
sch2.package = 3
sch2.save

sch3 = ch3.children.create
sch3.name = 'subch 3.1'
sch3.email = 'subchild_3_1@mlm.com'
sch3.package = 1
sch3.save
#users = 
#	User.create([{ name: 'Agustin', email: 'agustinh17@gmail.com', parent_id: root.id}, { name: 'Andy', email: 'andyjbas@gmail.com', parent_id: root.id} ])
