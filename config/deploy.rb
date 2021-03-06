# config valid only for current version of Capistrano
lock '3.3.5'

set :rvm_type, :user
set :rvm_ruby_version, '2.2'
set :application, 'linuxsimba'
set :repo_url, 'http://github.com/linuxsimba/linuxsimba.git'
set :branch, 'master'
#set :rvm_map_bins, fetch(:rvm_map_bins, []).push('jekyll')
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
#set :deploy_to, "/home/vagrant/blog"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  task :update_jekyll do
    on roles(:app) do
      within "#{deploy_to}/current" do
        execute :bundle, "exec jekyll build"
      end
    end
  end

  after "deploy:symlink:release", "deploy:update_jekyll"
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
