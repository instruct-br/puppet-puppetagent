# docs
class puppetagent::install {

  if 'Linux' == $facts['kernel'] {
    package { 'puppet-agent':
      ensure => $puppetagent::agent_version,
    }
  }

}
