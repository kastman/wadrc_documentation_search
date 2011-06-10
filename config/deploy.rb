$:.unshift(File.expand_path('./lib', ENV['rvm_path']))  # Add RVM's lib directory to the load path.
require "rvm/capistrano"                                # Load RVM's capistrano plugin.
require "bundler/capistrano"
require "whenever/capistrano"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "deployer"
set :group, "deployer"
set :deploy_to, "/var/www/html/wadrc_documentation_search"
set :application, "intranet.brainmap.wisc.edu/readme"


set :git, "/usr/local/bin/git"
set :repository,  "git@github.com:kastman/wadrc_documentation_search.git"
set :branch, "master"

set :rvm_ruby_string, '1.9.2'

default_environment['PATH'] = "/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin"

set :host_server, "intranet.brainmap.wisc.edu"
role :app, host_server
role :web, host_server
role :db,  host_server, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "rm -rf #{release_path}/public/assets"
    run "rm -rf #{release_path}/config/database.yml"

    run "cp #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
    run "ln -nfs #{release_path}/db/production.sqlite3 #{shared_path}/db/production.sqlite3"

    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:symlink', 'deploy:symlink_shared'
