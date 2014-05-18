# Install redhat dependencies
#
class pyenv::dependencies::redhat {
  exec { 'yum Group Install':
    unless  => '/usr/bin/yum grouplist "Development tools" | /bin/grep "^Installed Groups"',
      command => '/usr/bin/yum -y groupinstall "Development tools"',
  }
  if ! defined(Package['zlib'])                 { package { 'zlib':                 ensure => installed } }
  if ! defined(Package['zlib-devel'])           { package { 'zlib-devel':           ensure => installed } }
  if ! defined(Package['bzip2-devel'])          { package { 'bzip2-devel':          ensure => installed } }
  if ! defined(Package['git'])                  { package { 'git':                  ensure => installed } }
  if ! defined(Package['curl'])                 { package { 'curl':                 ensure => installed } }
  if ! defined(Package['openssl-devel'])        { package { 'openssl-devel':        ensure => installed } }
  if ! defined(Package['ncurses-devel'])        { package { 'ncurses-devel':        ensure => installed } }
  if ! defined(Package['sqlite-devel'])         { package { 'sqlite-devel':         ensure => installed } }
  if ! defined(Package['readline-devel'])       { package { 'readline-devel':       ensure => installed } }
  if ! defined(Package['tk-devel'])             { package { 'tk-devel':             ensure => installed } }
}
