#!/bin/bash

PROJNAME="crowdkit"
RAILS_ROOT="$HOME/workspace/$PROJNAME"
alias pj="cd $RAILS_ROOT && rvm use 1.9.2@$PROJNAME"

alias rdmd='pj && rake db:migrate RAILS_ENV=development'
alias rdmt='pj && rake db:migrate RAILS_ENV=test'
alias rdmp='pj && rake db:migrate RAILS_ENV=production'

alias c='pj && rails console'
alias ct='pj && RAILS_ENV=test rails console'

alias ngpj="pj && sudo cp $RAILS_ROOT/lib/shell/nginx.conf /opt/nginx/conf/nginx.conf"

alias gpom="git push origin master"
alias gppom="git pull origin master"
alias gph="git push heroku master"
alias gpa="gpom && gph"

alias ch='pj && heroku console'
alias tlh='pj && heroku logs --tail'
alias rh="pj && heroku restart --app $PROJNAME"
alias js3="pj && jammit-s3"

alias ttr='touch tmp/restart.txt'
alias ng='sudo /opt/nginx/sbin/nginx'
alias kng='sudo kill `cat /opt/nginx/logs/nginx.pid`'
alias rng='kng && ng'
alias m="mysql -uroot -ppassword $PROJNAME_dev"
alias myd='sudo /usr/local/mysql/bin/mysqld_safe --datadir=/usr/local/mysql/data --pid-file=/usr/local/mysql/data/cowboy.local.pid&'