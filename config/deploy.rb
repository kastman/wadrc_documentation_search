require "bundler/capistrano"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "admin"
set :group, "staff"
set :deploy_to, "/Library/WebServer/wadrc_documentation_search"
set :application, "readme.brainmap.wisc.edu"


set :git, "/usr/local/bin/git"
set :repository,  "git@github.com:kastman/wadrc_documentation_search.git"
set :branch, "master"

default_environment['PATH'] = "/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin"

set :host_server, "nelson.medicine.wisc.edu"
role :app, host_server
role :web, host_server
role :db,  host_server, :primary => true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  after "deploy:symlink", "deploy:update_crontab"
  
  desc "Update the crontab with Whenever."
  task :update_crontab do
    run "whenever --write-crontab wadrc_documentation_search -f #{File.join(release_path, 'config', 'schedule.rb')}"
  end
end