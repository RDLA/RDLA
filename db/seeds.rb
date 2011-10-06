#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Default category for fields
["Pleines", "Intermédiaires herbe", "Intermédiaires forêt hiver", "Intermédiaires forêt automne", "Intermédiaires neige", "Intermédiaires forêt été", 
  "Intermédiaires eau", "Intermédiaires montagne haute", "Intermédiaires montagne", "Intermédiaires montagne hiver",
  "Intermédiaires glace"].each do |category|
  
  cat = Category.find_or_initialize_by_name(category)
  cat.save
  
  end


# Default field
field = Field.find_or_initialize_by_filename("Herbe.png")
field.category_id = Category.find 1 
field.save



# Default map
map = Map.find_or_initialize_by_name("Aurorea")
map.default_field = field if map.default_field.blank?
map.save

# Default Weapons: Fist
weapon = Item::Weapon.find_or_initialize_by_name("Poing")
weapon.power_melee = 4
weapon.power_melee_step = 0
weapon.dexterity = 0
weapon.hands_number = 1
weapon.critical_rate = 1.25
weapon.price = 0
weapon.save

