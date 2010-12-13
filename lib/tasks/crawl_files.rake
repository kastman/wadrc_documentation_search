require File.dirname(__FILE__) + '/../textfile_tasks'

INCLUDED_PATHS = ['/Data/vtrak1/', '/Data/data4/', '/Data/data5/','/Data/data7']
# INCLUDED_PATHS = ['/Data/vtrak1/analyses/']
EXCLUDED_PATHS = ['/Data/vtrak1/SysAdmin/home','/Data/vtrak1/SysAdmin/apps','/Data/vtrak1/SysAdmin/lab_software_downloads','/Data/vtrak1/data1/apps', '/Data/vtrak1/data1/fm_apps']

namespace :crawler do
  desc "Crawl the filesystem looking for text files."
  task(:crawl_filesystem => :environment) do
    files = Find.match(:include_paths => INCLUDED_PATHS, :excluded_paths => EXCLUDED_PATHS) { |p| File.split(p)[1] =~ /(.*README.*|.*NOTE.*)/i }
    files.each do |file| 
      begin 
        f = Textfile.find_or_create_by_filepath(:filepath => file[:path], :content => file[:file_content], :accessed_at => Time.now )
        if f.save
          puts "Saved #{file[:path]}..."
        else
          raise StandardError, f.errors.full_messages.join(", ")
        end
      rescue StandardError => e
        puts "There was a problem saving file #{file[:path]}; #{e}"
      end
    end
  end
end
