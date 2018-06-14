use v6;

unit module Sparrowdo::VSTS::YAML::Solution:ver<0.0.1>;

use Sparrowdo;
use Sparrowdo::Core::DSL::Template;
use Sparrowdo::Core::DSL::Directory;
use Sparrowdo::Core::DSL::Bash;

our sub tasks (%args) {

  my $build-dir = %args<build-dir> || die "usage module_run '{ ::?MODULE.^name }' ,%(build-dir => dir)";

  directory "$build-dir/.cache";
  directory "$build-dir/files";

  template-create "$build-dir/.cache/build.yaml.sample", %(
    source => ( slurp %?RESOURCES<build.yaml> ),
    variables => %( 
      vs_version => %args<vs-version> || '15.0',
      solution => %args<solution> || '"**\*.sln"',
      platform => %args<platform> || 'x86',
      configuration => %args<configuration> || 'debug' ,
      restore_solution => %args<restore-solution> || '"**\*.sln"',
      skip_nuget_install => %args<skip-nuget-install>
    )
  );

  bash "cat $build-dir/.cache/build.yaml.sample >> $build-dir/build.yaml"

}


