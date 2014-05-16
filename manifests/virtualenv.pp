# The following part compiles and installs the chosen python version.
#
define pyenv::virtualenv(
  $user,
  $group   = $user,
  $home    = '',
  $root    = '',
  $target  = $home,
) {

  $home_path = $home ? { '' => "/home/${user}", default => $home }
  $root_path = $root ? { '' => "${home_path}/.pyenv", default => $root }

  $bin         = "${root_path}/bin"
  $shims       = "${root_path}/shims"
  $versions    = "${root_path}/versions"
  $global_path = "${root_path}/version"
  $path        = [ $shims, $bin, '/bin', '/usr/bin' ]

    exec { "pyenv::create-virtualenv ${user} ${name}":
      command     => "pyenv virtualenv ${name}",
      timeout     => 0,
      user        => $user,
      group       => $group,
      cwd         => $home_path,
      environment => [ "HOME=${home_path}" ],
      path        => $path,
      logoutput   => 'on_failure',
      creates     => "${versions}/${name}",
      before      => Exec["pyenv::local-virtualenv ${user} ${name}"],
      provider    => 'bash'
    }

    exec { "pyenv::local-virtualenv ${user} ${name}":
      command     => "pyenv local ${name}",
      timeout     => 0,
      user        => $user,
      group       => $group,
      cwd         => $target,
      environment => [ "HOME=${home_path}" ],
      path        => $path,
      logoutput   => 'on_failure',
      provider    => 'bash'
    }
}
