define storage::initialize (
  $repo,
  $version,
  $service,
  $local_dir,
  $target,
  $mode,
  $owner,
) {

  exec {
    "creating_target_for_${name}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      command   => "mkdir -p ${target}";

    "creating_local_package_repo_for_${name}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
      unless    => "test -d ${local_dir}",
      command   => "mkdir -p ${local_dir}";

    "downloading_wso2${service}-${version}.zip_for_${name}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      cwd       => $local_dir,
      unless    => "test -f ${local_dir}/wso2${service}-${version}.zip",
      command   => "wget -q ${repo}/wso2${service}-${version}.zip",
      logoutput => 'on_failure',
      creates   => "${local_dir}/wso2${service}-${version}.zip",
      timeout   => 0,
      require   => Exec["creating_local_package_repo_for_${name}",
                        "creating_target_for_${name}"];

    "extracting_wso2${service}-${version}.zip_for_${name}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      cwd       => $target,
      unless    => "test -d ${target}/wso2${service}-${version}/repository",
      command   => "unzip ${local_dir}/wso2${service}-${version}.zip",
      logoutput => 'on_failure',
      creates   => "${target}/wso2${service}-${version}/repository",
      timeout   => 0,
      require   => Exec["downloading_wso2${service}-${version}.zip_for_${name}"];

    "setting_permission_for_${name}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      cwd       => $target,
      command   => "chown -R ${owner}:${owner} ${target}/wso2${service}-${version} ;
                    chmod -R 755 ${target}/wso2${service}-${version}",
      logoutput => 'on_failure',
      timeout   => 0,
      require   => Exec["extracting_wso2${service}-${version}.zip_for_${name}"];
  }
}
