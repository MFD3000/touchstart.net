require 'bundler/capistrano'
default_run_options[:pty] = false
ssh_options[:forward_agent] = true
set :use_sudo, false

set :application, "touchstart.net"
set :repository,  "git://github.com/claco/touchstart.net.git"

set :scm, :git
set :branch, 'master'
set :git_shallow_clone, 1
set :copy_compression, :bz2
set :deploy_via, :remote_cache
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "momuggs@touchstart.net"                          # Your HTTP server, Apache/etc
role :app, "momuggs@touchstart.net"                          # This may be the same as your `Web` server
role :db,  "momuggs@touchstart.net", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :rails_env, 'production'
set :deploy_to, "/home/momuggs/#{application}"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

task :env do
  run 'env'
end

