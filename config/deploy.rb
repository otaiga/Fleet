require 'bundler/capistrano'
set :rvm_ruby_string, '1.9.2'

set :application, "fleet"
set :repository,  "git@github.com:otaiga/Fleet.git"
set :branch, "master"
set :scm, 'git'
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "Kturner2"
role :web, "www.karlturner.co.uk"                          # Your HTTP server, Apache/etc
role :app, "www.karlturner.co.uk"                          # This may be the same as your `Web` server
role :db,  "www.karlturner.co.uk", :primary => true # This is where Rails migrations will run

set :deploy_to, "/home/Kturner2/ruby/rails/fleet"
set :shared_path, "/home/Kturner2/ruby/rails/Fleet"
default_run_options[:pty] = true 

set :default_environment, {
  'PATH' => "/home/Kturner2/.rvm/gems/ruby-1.9.2-p290/bin:/home/Kturner2/.rvm/bin:/path/to/.rvm/rubies/ruby-1.9.2-p290/bin:$PATH",
  'RUBY_VERSION' => 'ruby 1.9.2',
  'GEM_HOME'     => '/home/Kturner2/.rvm/gems/ruby-1.9.2-p290:/home/Kturner2/.rvm/gems/ruby-1.9.2-p290@global',
  'GEM_PATH'     => '/home/Kturner2/.rvm/gems/ruby-1.9.2-p290:/home/Kturner2/.rvm/gems/ruby-1.9.2-p290@global',
  'BUNDLE_PATH'  => '/home/Kturner2/.rvm/gems/ruby-1.9.2-p290:/home/Kturner2/.rvm/gems/ruby-1.9.2-p290@global'  # If you are using bundler.
}


