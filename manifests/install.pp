# Internal class.
#
# This class can manage the Puppet Agent package version, if required.
# It should not be used directly.
#
class puppetagent::install {

  if $puppetagent::manage_package and 'Linux' == $facts['kernel'] {
    package { 'puppet-agent':
      ensure => $puppetagent::agent_version,
    }
  }

}
