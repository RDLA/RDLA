module RPG
  def dice(x = 1,y = 3,z = 0)
    #Simulate a dice in order to get XDY + Z
    result = 0
    x.times do
      result += Random.rand(y)+1
    end
    result += z
    
    result
  end
  
end