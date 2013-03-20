stage { pre: before => Stage[main] }

class apt_get_update {
	$sentinel = "/var/lib/apt/first-puppet-run"

	exec { "initial apt-get update":
		command => "/usr/bin/apt-get update && touch ${sentinel}",
		onlyif  => "/usr/bin/env test \\! -f ${sentinel} || /usr/bin/env test \\! -z \"$(find /etc/apt -type f -cnewer ${sentinel})\"",
		timeout => 3600,
	}
}
node default {
	class { 'apt_get_update':
		stage => pre,
	}

	# Install prerequisites
	package { 'build-essential':
		ensure => present,
	}

	package { 'curl':
		ensure => present,
	}

	package { 'python':
		ensure => present,
	}
	package { ['python-sphinx', 'python-yaml', 'python-argparse']:
		ensure  => present,
		require => Package['python']
	}

	package { 'git':
		ensure => present,
	}

		# Install web server, set up site and permissions
	class { 'nginx': }
	nginx::resource::vhost { 'mongodb-docs':
		ensure   => present,
		www_root => '/var/www/mongodb-docs/build/master/html',
	}

	user { 'vagrant':
		ensure => present,
		groups => 'www-data'
	}

	file { '/var/www/':
		ensure => directory,
		owner => 'www-data',
		group => 'www-data',
		mode  => '755',
	}

	# Clone the docs
	exec { 'git clone mongodb-docs':
		command  => '/usr/bin/git clone git://github.com/mongodb/docs.git /var/www/mongodb-docs',
		creates  => '/var/www/mongodb-docs',
		require => [ Package['git'], File['/var/www/'] ]
	}
	exec { 'set permissions':
		command  => '/bin/chown -R www-data:www-data /var/www/mongodb-docs && /bin/chmod -R 775 /var/www/mongodb-docs',
		require => Exec['git clone mongodb-docs']
	}

	# Create a convenience link from the home directory
	file { '/home/vagrant/mongodb-docs/':
		ensure => 'link',
		target => '/var/www/mongodb-docs/',
	}
}
