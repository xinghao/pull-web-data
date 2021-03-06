# Staging

set :user, 'xinghao'

set :application, "pull-web-data"
set :hostname, ""
set :rails_env, 'staging'
set :deploy_to, "/opt/apps/#{application}"
set :cron, "cron7"

role :app, "64.150.191.90"
role :web, "64.150.191.90"
role :db,  "64.150.191.90", :primary => true

set :branch do
  default_tag = `git tag -l #{rails_env}* `.split("\n").last
  tag = Capistrano::CLI.ui.ask "Please enter the tag you would like to deploy to #{rails_env} (make sure the tag has been pushed first): [#{default_tag}] "
  tag = default_tag if tag.empty?
  tag
end
