#encoding: utf-8
class Admin::TerraformingsController < Admin::AreaController
  layout false
  def index
    if session[:terraforming_map_id].blank?
      session[:terraforming_map_id] = 1
      session[:terraforming_posx] = 0
      session[:terraforming_posy] = 0
      session[:terraforming_width] = 10
      session[:terraforming_height] = 10
    end
    
    @map = Map.find session[:terraforming_map_id].to_i
    @posx = session[:terraforming_posx].to_i
    @posy = session[:terraforming_posy].to_i
    @width = session[:terraforming_width].to_i
    @height = session[:terraforming_height].to_i
    
    @fields = @map.get_fields(@posx, @posy, [@width, @height].max )
    
    
     @fields_library = Field.all
      @maps = Map.all
    
  end

  private

end