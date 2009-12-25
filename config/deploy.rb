default_run_options[:pty] = true

# be sure to change these
set :user, 'armitage'
set :domain, 'photoblog.plasticity.com'
set :application, 'photoblog'

# the rest should be good
set :repository,  "git@github.com:dannyw/photoblog.git"
set :deploy_to, "/home/#{user}/#{domain}" 
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false

server domain, :app, :web
role :db, domain, :primary => true

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end
  
  task :after_update_code do
    run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "cp #{shared_path}/config/config.yml #{release_path}/config/config.yml"
  end
end