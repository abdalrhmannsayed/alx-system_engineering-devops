# create a manifest that kills a process named killmenow.
exec { 'killmenow_process':
  command  => 'pkill killmenow',
  provider => shell,
  path     => '/usr/bin/',
}
