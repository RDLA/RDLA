# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Default field
field = Field.find_or_initialize_by_filename("Herbe.png")
field.save

# Default map
map = Map.find_or_initialize_by_name("Aurorea")
map.default_field = field if map.default_field.blank?
map.save
