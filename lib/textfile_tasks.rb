require 'find'
module Find
  def match(paths, &block)
    matched=[]
    excluded_paths = Set.new(paths[:excluded_paths])
    excluded_paths.each {|path| puts "Excluding #{path}" }

    paths[:include_paths].each do |include_path|
      find(include_path) do |path| 
        if excluded_paths.include?(path)
          puts "Pruned #{path}"
          Find.prune 
        end
        
        m = matches?(path, &block)
        if m.kind_of? Hash
          matched << m
          print "*"
        else
          print "."
        end
        STDOUT.flush
      end
      return matched
    end
  end
  
  def matches?(path)
    # puts path

    if yield path then
      if File.file?(path) && File.readable?(path) then file_content = open(path) { |f| f.read } end
      return { :path => path, :file_content => file_content }
    end
  end


  module_function :match, :matches?

end

# Find.match('/tmp/') { |p| File.basename(p) =~ /README/i}