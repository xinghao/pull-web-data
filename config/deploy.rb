# Multi-stage deployment file.
#
# Stages will likely just need to set the following Cap configurations:
#
# set :application, "app-name"
# set :branch, "git-branch"
# set :rails_env, 'rails-env'
#
set :stages, %w(cron2 cron3 cron4 cron9 cron10)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

set :scm, 'git'
set :repository,  "git@github.com:Creagency/pull-web-data.git"
set :branch, "master"

set :db_type, "master"

set :user, 'xinghao'
set :use_sudo, true
ssh_options[:port] = 54102
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :deploy_via, :remote_cache
set :cron, ""

before "deploy:setup" , "deploy:pre_setup"

after "deploy:update" , "deploy:post_deploy"

#after "deploy:setup" , "deploy:startup_script"
#after "deploy:update_code" , "deploy:post_deploy"
#after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  
  task :pre_setup do
    sudo "[ -d /opt/apps/pull-web-data ] || #{sudo} mkdir /opt/apps/pull-web-data"
    #sudo "[ -d /SOLR/SolrServer ] || #{sudo} mkdir /SOLR/SolrServer"
    sudo "[ -d /opt/apps/pullwebdata/releases ] || #{sudo} mkdir /opt/apps/pull-web-data/releases"
#    sudo "chown svc-rails.kazaaadm /SOLR"
  end
  
  task :install_server_scripts do
    # sudo "cp -f #{latest_release}/server_configs/etc/logrotate.d/varnish /etc/logrotate.d/varnish"
    # sudo "cp -f #{latest_release}/server_configs/etc/rc.d/init.d/solr /etc/init.d/solr"
    # sudo "cp -f #{latest_release}/server_configs/etc/rc.d/init.d/varnish /etc/init.d/varnish"
    # sudo "cp -f #{latest_release}/server_configs/etc/rc.d/init.d/varnishncsa /etc/init.d/varnishncsa"
    # sudo "cp -f #{latest_release}/server_configs/etc/sysconfig/varnish /etc/sysconfig/varnish"
    # sudo "cp -f #{latest_release}/server_configs/etc/varnish/default.vcl /etc/varnish/default.vcl"
  end
  
  task :start do
    # sudo "nohup /etc/init.d/solr start"
  end
  
  task :stop do
    # sudo "/etc/init.d/solr stop"
  end
  
  task :restart do
    # sudo "nohup /etc/init.d/solr restart"
  end
    
  desc 'Tag release'
  task :tag_release do
    `git tag #{rails_env}_#{DateTime.now.strftime "%Y_%m_%d-%H_%M"}`
    `git push --tags`
    #`git checkout master`
  end
  
  task :post_deploy do

    sudo "rm -f #{latest_release}/config/initializers/crons.rb"
    #sudo "echo  #{cron} > #{latest_release}/config/initializers/crons.rb"
    # sudo "cp -f #{latest_release}/SolrServer/bin/jetty.sh.#{rails_env} #{latest_release}/SolrServer/bin/jetty.sh"
    # sudo "cp -f #{latest_release}/SolrServer/newrelic/newrelic.yml.#{rails_env} #{latest_release}/SolrServer/newrelic/newrelic.yml"

    # if ["staging", "production"].include?(rails_env)
    #   run "echo Setting up no logging jetty.xml config"
    #   sudo "cp -f #{latest_release}/SolrServer/etc/jetty.xml.#{rails_env} #{latest_release}/SolrServer/etc/jetty.xml"
    # end

    # if slave then setup slave config
    # if db_type == "slave"
    #   run "echo Setting up Slave config"
    #   sudo "cp -f #{latest_release}/SolrServer/solr/multicore/conf/solrconfig.xml.slave #{latest_release}/SolrServer/solr/multicore/conf/solrconfig.xml"
    # end
    
  end
  
end

task :invoke do
  require 'shellwords'
  command = "cd #{latest_release}; RAILS_ENV=#{rails_env} rake #{ENV['TASK']} --trace"
  run("echo #{Shellwords.escape(command)} | at -m now")
end

