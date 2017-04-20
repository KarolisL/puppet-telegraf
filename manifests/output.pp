# == Define: telegraf::input
#
# A Puppet wrapper for discrete Telegraf input files
#
# === Parameters
#
# [*options*]
#   Hash. Plugin options for use the the input template.
#
# [*sections*]
#   Hash. Some inputs take multiple sections.
#
define telegraf::output (
  $plugin_type = $name,
  $options     = undef,
  $suboptions  = undef,
) {
  include telegraf

  notice("Creating: ${name} :: ${plugin_type}")

  if $options {
    validate_hash($options)
  }

  if $sections {
    validate_hash($sections)
  }

  Class['::telegraf::config']
  ->
  file { "${telegraf::config_folder}/output-${name}.conf":
    content => template('telegraf/output.conf.erb'),
  }
  ~>
  Class['::telegraf::service']
}
