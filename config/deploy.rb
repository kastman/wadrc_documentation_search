require "bundler/capistrano"
require "whenever/capistrano"

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
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "rm -rf #{release_path}/public/assets"
    run "cp #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
    run "rm -rf #{release_path}/config/database.yml"
    #run "rm -rf #{release_path}/images/*"
    
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/initializers/akismet.rb #{release_path}/config/initializers/akismet.rb"

    run "ln -nfs #{release_path}/db/production.sqlite3 #{shared_path}/db/production.sqlite3"

    #run "ln -nfs #{shared_path}/images #{release_path}/public/images"
  end
end

after 'deploy:symlink', 'deploy:symlink_shared'
