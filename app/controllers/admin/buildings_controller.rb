#encoding: utf-8
class Admin::BuildingsController < Admin::AreaController
	before_filter :find_all_maps, :only => [:edit, :new]
	
	def create
	  create! { admin_buildings_path}
	end
	def update
	  update! { admin_buildings_path}
	end
	def find_all_maps
    @maps = Map.all
  end
end
