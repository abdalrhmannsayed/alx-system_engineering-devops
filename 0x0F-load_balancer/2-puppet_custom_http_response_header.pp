# Setup New Ubuntu server wit custom HTTP header

exec { 'update system':
        command => '/usr/bin/apt-get update',
}

package { 'nginx':
	ensure => 'installed',
	require => Exec['update system']
}

file {'/var/www/html/index.html':
	content => 'Hello World!'
}

# Edit /etc/nginx/sites-enabled/default
# Configure Nginx site
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => "server {
                listen 80 default_server;
                listen [::]:80 default_server;
		rewrite ^/redirect_me https://github.com/Bedwey permanent;
	        error_page 404 /not_found.html;
		root /var/www/html;                
		index index.html index.htm index.nginx-debian.html;
		server_name _;
		
                location / {
                  add_header X-Served-By $hostname;
                  root /var/www/html;
                }
              }",
  require => Package['nginx'],
  notify  => Service['nginx'],
}


# Enable Nginx default site
file { '/etc/nginx/sites-enabled/default':
  ensure => link,
  target => '/etc/nginx/sites-available/default',
  notify => Service['nginx'],
}

service {'nginx':
	ensure => running,
	require => Package['nginx']
}
