# Staging

set :user, 'xinghao'
ssh_options[:port] = 23452
set :application, "kazaa_metadata"
set :hostname, ""
set :rails_env, 'staging'
set :deploy_to, "/opt/apps/#{application}"
set :cron, "php3"

role :app, "67.228.198.72"
role :web, "67.228.198.72"
role :db,  "67.228.198.72", :primary => true

set :branch do
  default_tag = `git tag -l #{rails_env}* `.split("\n").last
  tag = Capistrano::CLI.ui.ask "Please enter the tag you would like to deploy to #{rails_env} (make sure the tag has been pushed first): [#{default_tag}] "
  tag = default_tag if tag.empty?
  tag
end
