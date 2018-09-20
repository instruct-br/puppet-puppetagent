# Puppetagent class.
#
# This is a class to install and manage PuppetAgent:
#
# @example Declaring the class
#   include puppetagent
#
# @param [String] agent_certname Certificate name for the agent
# @param [String] agent_version Package version for puppet-agent
# @param [String] agent_environment Set the environment for puppet-agent
# @param [Integer] agent_runinterval Set the interval between agent runs
# @param [String] agent_server Set the puppet server for the agent
# @param [String] ca_server Set the puppet ca server for the agent
# @param [Boolean] manage_package Enable the agent package management. Default: true
#
class puppetagent (
  String $agent_certname,
  String $agent_version,
  String $agent_environment,
  Integer $agent_runinterval,
  String $agent_server,
  String $ca_server,
  Boolean $manage_package = true,
) {

  include puppetagent::install
  include puppetagent::config
  include puppetagent::service

  Class['puppetagent::install']
  -> Class['puppetagent::config']
    -> Class['puppetagent::service']

}
