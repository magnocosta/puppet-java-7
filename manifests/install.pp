# -*- mode: ruby -*-
# vi: set ft=ruby :

class java::install {

    exec { "add-repository-apt":
        command  => "add-apt-repository ppa:webupd8team/java",
        unless   => "grep -Ec java /etc/apt/sources.list.d/*.list",
        required => Class["common::basic"]
    }

    exec { "apt-update-java":
        command => "/usr/bin/apt-get update",
        require => Exec["add-repository-apt"]
    }

    package { "oracle-java7-installer":
        ensure => installed,
        required => Exec["apt-update-java"]
    }

}

