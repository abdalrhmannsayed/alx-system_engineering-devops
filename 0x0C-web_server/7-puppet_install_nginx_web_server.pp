# Setup New Ubuntu server with nginx

# Update System
exec { 'update system':
        command => '/usr/bin/apt-get update',
}

# Install nginx
package { 'nginx':
	ensure => 'installed',
	require => Exec['update system']
}

# Add home page
file {'/var/www/html/index.html':
	content => 'Hello World!'
}

# Config redirect
exec {'redirect_me':
	command => 'sed -i "24i\	rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;" /etc/nginx/sites-enabled/default',
	provider => 'shell'
}

# Start nginx service
service {'nginx':
	ensure => running,
	require => Package['nginx']
}
