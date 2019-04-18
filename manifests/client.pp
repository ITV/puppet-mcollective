# private class
# Installs the client and sets up /etc/mcollective/client.cfg (global/common
# configuration)
class mcollective::client {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  contain ::mcollective::client::install
  class{ '::mcollective::client::config':
    owner => $::mcollective::client_config_owner,
    group => $::mcollective::client_config_group,
    mode  => $::mcollective::client_config_mode,
  }

  Class['mcollective::client::install']
  -> Class['mcollective::client::config']
}
