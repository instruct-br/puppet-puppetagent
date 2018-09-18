require 'spec_helper'
describe 'puppetagent', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile }
      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('puppetagent') }
      it { is_expected.to contain_class('puppetagent::install').that_comes_before('Class[puppetagent::config]') }
      it { is_expected.to contain_class('puppetagent::config').that_comes_before('Class[puppetagent::service]') }
      it { is_expected.to contain_class('puppetagent::service') }

      context 'puppetserver::install' do
        case facts[:kernel]
        when 'Linux'
          it { is_expected.to contain_package('puppet-agent') }
        end
      end

      context 'puppetserver::config' do
        case facts[:kernel]
        when 'Linux'
          it { is_expected.to contain_augeas('agent_certname').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
          })}
          it { is_expected.to contain_augeas('agent_server').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
          })}
          it { is_expected.to contain_augeas('agent_runinterval').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
          })}
          it { is_expected.to contain_augeas('agent_environment').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
          })}
        when 'windows'
          it { is_expected.to contain_ini_setting('agent_certname').with({
            'path' => 'c:/ProgramData/PuppetLabs/puppet/etc/puppet.conf',
          })}
          it { is_expected.to contain_ini_setting('agent_server').with({
            'path' => 'c:/ProgramData/PuppetLabs/puppet/etc/puppet.conf',
          })}
          it { is_expected.to contain_ini_setting('agent_runinterval').with({
            'path' => 'c:/ProgramData/PuppetLabs/puppet/etc/puppet.conf',
          })}
          it { is_expected.to contain_ini_setting('agent_environment').with({
            'path' => 'c:/ProgramData/PuppetLabs/puppet/etc/puppet.conf',
          })}
        end
      end

      context 'puppetserver::service' do
        it { is_expected.to contain_service('puppet').with({
          'ensure' => 'running',
          'enable' => true,
          })
        }
      end

    end
  end

end
