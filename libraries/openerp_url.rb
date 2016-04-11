module OpenERP
  module NameHelper
    def openerp_server_tarball_url
      "http://nightly.openerp.com/old/openerp-#{openerp_short_version}/#{openerp_version}/#{openerp_server_tarball}"
    end

    def openerp_unix_name
      if openerp_short_version <= 6.0
        'openerp-server'
      else
        # From 6.1 on the webclient is integrated in the server, and the
        # server package is renamed to just "openerp"
        'openerp'
      end
    end

    def openerp_server_tarball
      "#{openerp_unix_name}-#{openerp_short_version}-20140804-#{openerp_subversion}.tar.gz"
    end

    def openerp_version
      node['openerp']['version']
    end

    def openerp_subversion
      node['openerp']['subversion']
    end

    # '6.1-1', '6.1rc1' => 6.1
    def openerp_short_version
      openerp_version[/\d+\.\d+/].to_f
    end
  end
end

[::Chef::Recipe,
 ::Chef::Resource::RemoteFile,
 ::Chef::Resource::Bash,
 ::Chef::Resource::Template,
 ::Chef::Resource::Link
].each { |mod| mod.send(:include, ::OpenERP::NameHelper) }
