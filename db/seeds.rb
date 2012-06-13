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
  user_attributes[:home_phone] = "1111111111"
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
root.home_phone="1111111111"
root.package="1"
root.cell='1111111111'
root.referer_id = 123456
root.save
