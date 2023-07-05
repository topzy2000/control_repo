node default {
}
node 'puppetmaster02.temioye.com' {
  include role::master_server
}
node 'puppetmaster02.temioye.com' {
  include role::base
  include role::base
}
