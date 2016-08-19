class { 'pe_external_postgresql' :
    postgres_root_password   => 'Temporal1',
    puppetdb_db_password     => 'Temporal1',
    classifier_db_password   => 'Temporal1',
    rbac_db_password         => 'Temporal1',
    activity_db_password     => 'Temporal1',
    orchestrator_db_password => 'Temporal1',
  }
