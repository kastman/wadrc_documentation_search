require File.dirname(__FILE__) + '/../textfile_tasks'

INCLUDED_PATHS = ['/Data/vtrak1/']
EXCLUDED_PATHS = ['/Data/vtrak1/SysAdmin/home','/Data/vtrak1/SysAdmin/apps','/Data/vtrak1/SysAdmin/lab_software_downloads','/Data/vtrak1/data1/apps', '/Data/vtrak1/data1/fm_apps']

namespace :crawler do
  task(:crawl_filesystem => :environment) do
    files = Find.match(:include_paths => INCLUDED_PATHS, :excluded_paths => EXCLUDED_PATHS) { |p| File.split(p)[1] =~ /.*README.*/i }
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