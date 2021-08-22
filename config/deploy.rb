# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "codemonks"
set :repo_url, "git@github.com:DomnicAmalan/codemonks.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/codemonks"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, 'main.config.js', '.env'

# Default value for linked_dirs is []
append :linked_dirs, "node_modules"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }

set :pm2_process_file, "/var/www/#{fetch(:application)}/shared/main.config.js"
set :pm2_app_name, 'codemonks'
set :pm2_target_path, -> { release_path }         # where to run pm2 commands
set :pm2_roles, :all                              # server roles where pm2 runs on
set :yarn_target_path, -> { release_path }        # default not set
set :yarn_roles, :all                                     # default

namespace :deploy do
  desc 'Restart application'
  task :restart do
    # invoke 'pm2:delete'
    invoke 'pm2:restart'
  end

  task :build do
    on roles(:web) do
      execute "cd /var/www/#{fetch(:application)}/current && yarn run build"
    end
  end

  after :publishing, :build
  after :publishing, :restart
end
