# -*- mode: ruby -*-
# vi: set ft=ruby :

class java::install {

    exec { "add-repository-apt":
        command  => "add-apt-repository ppa:webupd8team/java",
        unless   => "grep -Ec java /etc/apt/sources.list.d/*.list",
        require => Class["common::basic"]
    }

    exec { "apt-update-java":
        command => "/usr/bin/apt-get update",
        require => Exec["add-repository-apt"]
    }

    package { "oracle-java7-installer":
        ensure  => installed,
        require => Exec["apt-update-java"]
    }

}

