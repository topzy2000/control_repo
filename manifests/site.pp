node default {
}
node 'puppetmaster02.temioye.com' {
  include role::master_server
}
