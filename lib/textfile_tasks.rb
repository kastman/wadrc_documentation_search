require 'find'
module Find
  def match(paths)
    matched=[]
    excluded_paths = Set.new(paths[:excluded_paths])
    excluded_paths.each {|path| puts "Excluding #{path}" }

    paths[:include_paths].each do |include_path|
      find(include_path) do |path| 
        puts path
        if excluded_paths.include?(path)
          puts "Pruned #{path}"
          Find.prune 
        end
        if yield path then
          if File.file?(path) && File.readable?(path) then file_content = open(path) { |f| f.read } end
          matched << { :path => path, :file_content => file_content }
        end
      end
      return matched
    end
  end
  module_function :match
end

# Find.match('/tmp/') { |p| File.split(p)[1] == "README"}