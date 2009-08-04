require File.dirname(__FILE__) + '/../textfile_tasks'

FILESYSTEM_ROOT = '/Data/vtrak1/'

namespace :crawler do
  task(:crawl_filesystem => :environment) do
    files = Find.match(FILESYSTEM_ROOT) { |p| File.split(p)[1] =~ /.*README.*/i }
    files.each do |file| 
      begin 
        f = Textfile.find_or_create_by_filepath(:filepath => file[:path], :content => file[:file_content], :accessed_at => Time.now )
        f.save
      rescue
        puts "There was a problem saving file #{file[:path]}"
      end
    end
  end
end