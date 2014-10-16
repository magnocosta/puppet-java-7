# -*- mode: ruby -*-
# vi: set ft=ruby :

class java::install {

    exec { 'add-repository-apt':
        command  => 'sudo add-apt-repository ppa:webupd8team/java',
        unless   => 'grep -Ec java /etc/apt/sources.list.d/*.list',
        path     => ['/bin', '/usr/bin'],
        require  => Class['common::basic']
    }

    exec { 'apt-update-java':
        command => '/usr/bin/apt-get update',
        require => Exec['add-repository-apt']
    }

    exec { 'accepted-oracle-terms':
        command => 'sudo echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections',
        path    => ['/bin', '/usr/bin'],
        before  => Package['oracle-java7-installer']
    }

    package { 'oracle-java7-installer':
        ensure  => installed,
        require => Exec['apt-update-java']
    }

}

