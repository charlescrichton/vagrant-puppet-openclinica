

node default {

	file { "/vagrant/downloads":
	    ensure => "directory",
	}

	file { "/home/vagrant/jdk6":
	    ensure => "directory",
	}

	include wget
	wget::fetch { "Download jdk-6u24-linux-x64.bin":
	       source      => 'http://svn.akazaresearch.com/oc/software/OpenClinica-3.1/linux/jdk-6u24-linux-x64.bin',
	       destination => '/vagrant/downloads/jdk-6u24-linux-x64.bin',
		   redownload  => false,
	       timeout     => 0,
	       verbose     => true,
		   require     => File["/vagrant/downloads"],
		   
	}
	 
	java::setup {"jdk-6u24-linux-x64":	
    ensure        => present,
	cachedir      => '/vagrant/downloads',
	 source        => 'jdk-6u24-linux-x64.bin',
	 deploymentdir => '/home/vagrant/jdk6',
	 user          => 'root',
	 require => [ Wget::Fetch["Download jdk-6u24-linux-x64.bin"], File["/home/vagrant/jdk6"]]	
	}

#import 'tomcat.pp'
#import 'db.pp'
#import 'openclinica.pp'
#import 'settings.pp'

}

#node 'parent' {
  #Exec { 
  #  path => ['/bin', '/usr/bin'],
  #}

#  class { 'epel': } ->
#  class { 'avahi': }
#}

#Oracle - 6.2.4

#Tomcat 6.0.32

#Postgres 8.4.1-1
