node default {
}
node 'puppetmaster02.temioye.com' {
  include role::master_server
}
#node /^node/ {
 # include role::app_server
#}
#hiera_include('classes')
