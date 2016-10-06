class profile {
  $postgres_root_password   = "Temporal1"
  $puppetdb_db_password     = "Temporal1"
  $classifier_db_password   = "Temporal1"
  $rbac_db_password         = "Temporal1"
  $activity_db_password     = "Temporal1"
  $orchestrator_db_password = "Temporal1"
  $postgresql_version       = '9.4'
  $console                  = true
  $puppetdb                 = true
  $orchestrator             = true
  $datadir              = '/apps/psql/data'
  $manage_package_repo  = true

  class { '::postgresql::globals':
    version              => $postgresql_version,
    datadir              => $datadir,
    manage_package_repo  => $manage_package_repo,
  } ->
  class { '::postgresql::server':
    ip_mask_deny_postgres_user => '0.0.0.0/32',
    ip_mask_allow_all_users    => '0.0.0.0/0',
    listen_addresses           => '*',
    postgres_password          => $postgres_root_password,
    encoding                   => 'utf8',
    locale                     => 'en_US.utf8',
  }

  include postgresql::server::contrib

  ::postgresql::server::config_entry { 'max_connections':
    value => '400',
    ensure => present,
  }

  if $puppetdb {
    # PuppetDB Database
    pe_external_postgresql::database { 'pe-puppetdb':
      db_password => $puppetdb_db_password,
      extensions  => [ 'pg_trgm', 'pgcrypto' ],
    }
  }

  if $console {
    #Classifier database
    pe_external_postgresql::database { 'pe-classifier':
      db_password => $classifier_db_password,
    }

    # RBAC Database
    pe_external_postgresql::database { 'pe-rbac':
      db_password => $rbac_db_password,
      extensions  => [ 'citext' ],
    }

    # Activity service database
    pe_external_postgresql::database { 'pe-activity':
      db_password => $activity_db_password,
    }
  }

  if $orchestrator {
    # Orchestrator database
    pe_external_postgresql::database { 'pe-orchestrator':
      db_password => $orchestrator_db_password,
    }
  }
}

include profile
