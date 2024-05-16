# Manage the content of the /etc/default/nginx file to set ulimit value
exec {'replace ulimit value':
  command  => "sed -i 's/-n 15/-n 4096/g' /etc/default/nginx",
  provider => shell,
}

# Manage the nginx service, ensuring it's running
exec {'restart nginx':
  command  => '/etc/init.d/nginx restart',
  provider => shell,
}
