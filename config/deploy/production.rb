# Staging

set :user, 'svc-rails'
set :application, "SolrServer"
set :hostname, "solr01.kazaa.com"
set :rails_env, 'production'
set :deploy_to, "/SOLR/#{application}"

set :db_type, "master"

role :app, "10.5.23.201"
role :web, "10.5.23.201"
role :db,  "10.5.23.201", :primary => true

set :branch do
  default_tag = `git tag -l #{rails_env}* `.split("\n").last
  tag = Capistrano::CLI.ui.ask "Please enter the tag you would like to deploy to #{rails_env} (make sure the tag has been pushed first): [#{default_tag}] "
  tag = default_tag if tag.empty?
  tag
end
