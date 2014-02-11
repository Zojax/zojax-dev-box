class zojaxbox {

  exec { 'apt-get update': command => '/usr/bin/apt-get update' }

  file { "/home/vagrant/zojax":
    ensure => "directory",
    owner => "vagrant",
    group => "vagrant",
  }

  class preinstall {
    package { 'python-software-properties': ensure  => installed }

    file { "/etc/apt/sources.list.d/puppet.list":
      content => "deb http://archive.canonical.com/ubuntu/ lucid partner\n",
      owner   => root,
      group   => root,
      mode    => 0644,
      notify  => Exec["apt-get update"]
    }

    exec {
      'add-deadsnakes-ppa':
        command => '/usr/bin/sudo /usr/bin/add-apt-repository ppa:fkrull/deadsnakes && touch /tmp/add-deadsnakes-ppa',
        require => Package['python-software-properties'],
        creates => '/tmp/add-deadsnakes-ppa';

      'apt-get-update-deadsnakes':
        command => '/usr/bin/apt-get update && touch /tmp/apt-get-update-deadsnakes',
        require => Exec['add-deadsnakes-ppa'],
        creates => '/tmp/apt-get-update-deadsnakes';
    }
  }

  include preinstall

  # install required system packages
  Package { ensure => "installed" }

  $packages = [
    "linux-image-virtual",
    "linux-headers-virtual",
    "nfs-kernel-server",
    "git-core",
    "build-essential",
    "python-svn",
    "default-jre-headless",
    "python-dev",
    "libssl-dev",
    "pkg-config",

    "memcached",
    "subversion",
    "python-roman",
    "python2.5",
    "python2.5-dev",
    "libc6-dev",
    "libpq-dev",
    "libxslt1-dev",
    "libsqlite3-dev",

    "libjpeg62-dev",
    "libfreetype6-dev",
    "zlib1g-dev",
    "libgif-dev",
    "libpcre3-dev",

    "xpdf",
    "a2ps",
    "html2ps",
    "jodconverter",
    "swftools",

    "mc",
    "apache2"
  ]

  package { $packages:
    require => [
      Class[ "preinstall" ],
      Exec[ "apt-get update" ],
      File[ "/home/vagrant/zojax" ],
    ],
  }

}

include zojaxbox
