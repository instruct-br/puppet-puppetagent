# docs
class puppetagent::config {

  if 'Linux' == $facts['kernel'] {

    Augeas {
      context => '/files/etc/puppetlabs/puppet/puppet.conf',
      notify  => Service['puppet'],
    }

    augeas { 'agent_certname':
      changes => [ "set agent/certname ${puppetagent::agent_certname}", ],
    }

    augeas { 'agent_server':
      changes => [ "set main/server ${puppetagent::agent_server}", ],
    }

    augeas { 'agent_caserver':
      changes => [ "set main/ca_server ${puppetagent::ca_server}", ],
    }

    augeas { 'agent_environment':
      changes => [ "set agent/environment ${puppetagent::agent_environment}", ],
    }

    augeas { 'agent_runinterval':
      changes => [ "set agent/runinterval ${puppetagent::agent_runinterval}", ],
    }
  }

  if 'windows' == $facts['kernel'] {

    $version = $::facts['os']['release']['major']
    case $version {
      '2003', '2003 R2': {
        $puppet_conf = 'c:/Documents and Settings/All Users/Application Data/PuppetLabs/puppet/etc/puppet.conf'
      }
      '2008', '2008 R2', '2012', '2012 R2', '2016': {
        $puppet_conf = 'c:/ProgramData/PuppetLabs/puppet/etc/puppet.conf'
      }
      default: {
        $puppet_conf = 'c:/ProgramData/PuppetLabs/puppet/etc/puppet.conf'
      }
    }

    Ini_setting {
      path    => $puppet_conf,
      section => 'agent',
      notify  => Service['puppet']
    }

    ini_setting { 'agent_certname':
      setting => 'certname',
      value   => $puppetagent::agent_certname,
    }

    ini_setting { 'agent_server':
      setting => 'server',
      section => 'main',
      value   => $puppetagent::agent_server,
    }

    ini_setting { 'agent_caserver':
      setting => 'ca_server',
      section => 'main',
      value   => $puppetagent::ca_server,
    }

    ini_setting { 'agent_environment':
      setting => 'environment',
      value   => $puppetagent::agent_environment,
    }

    ini_setting { 'agent_runinterval':
      setting => 'runinterval',
      value   => $puppetagent::agent_runinterval,
    }
  }

}
