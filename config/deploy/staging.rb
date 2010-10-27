# Staging

set :user, 'root'

set :application, "SolrServer"
set :hostname, "solr01.kazaa.com"
set :rails_env, 'staging'
set :deploy_to, "/SOLR/#{application}"

set :db_type, "master"

role :app, "184.72.231.47"
role :web, "184.72.231.47"
role :db,  "184.72.231.47", :primary => true

set :branch do
  default_tag = `git tag -l #{rails_env}* `.split("\n").last
  tag = Capistrano::CLI.ui.ask "Please enter the tag you would like to deploy to #{rails_env} (make sure the tag has been pushed first): [#{default_tag}] "
  tag = default_tag if tag.empty?
  tag
end
