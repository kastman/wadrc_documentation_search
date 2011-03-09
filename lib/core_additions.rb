
class String
  # http://stackoverflow.com/questions/1451384/how-can-i-center-truncate-a-string/1452815#1452815
  # def ellipsisize(minimum_length=4,edge_length=3)
  #   return self if self.length < minimum_length or self.length <= edge_length*2 
  #   edge = '.'*edge_length    
  #   mid_length = self.length - edge_length*2
  #   gsub(/(#{edge}).{#{mid_length},}(#{edge})/, '\1...\2')
  # end
  
  def ellipsisize(maximum_length=80)
    return self if self.length < maximum_length
    mid_length = self.size - maximum_length
    edge_length = (maximum_length / 2) - 3
    edge = '.'*edge_length    
    gsub(/(#{edge}).{#{mid_length},}(#{edge})/, '\1...\2')
  end
  
end