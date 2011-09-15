class Field < ActiveRecord::Base
  require 'open-uri'
  def self.get_distant_fields_picture
    list = open("#{ASSETS_URL}list.php")
    file = []
    list.each do |line|
      file << (line.delete "\n")
    end
    list.close
    file
  end
end