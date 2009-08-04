require 'find'
module Find
  def match(*paths)
    matched=[]
    find(*paths) do |path| 
      p path
      if yield path then
        if File.file?(path) && File.readable?(path) then file_content = open(path) { |f| f.read } end
        #file_content = nil
        matched << { :path => path, :file_content => file_content }
      end
    end
    return matched
  end
  module_function :match
end

# Find.match('/tmp/') { |p| File.split(p)[1] == "README"}