include stdlib

# set up your client SSH configuration file so that you can connect to a server without typing a password.
file_line {'Turn off passwd auth':
  path               => '/etc/ssh/ssh_config',
  line               => 'PasswordAuthentication no',
  match              => '^[#]+[\s]*(?i)PasswordAuthentication[\s]+(yes|no)$',
  replace            => true,
  append_on_no_match => true
}

file_line {'Declare identity file':
  path               => '/etc/ssh/ssh_config',
  line               => 'IdentityFile ~/.ssh/school',
  match              => '^[#]+[\s]*(?i)IdentityFile[\s]+~/.ssh/id_rsa$',
  replace            => true,
  append_on_no_match => true
}
