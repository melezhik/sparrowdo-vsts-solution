use v6;

unit module Sparrowdo::VSTS::YAML::Solution:ver<0.0.3>;

use Sparrowdo;
use Sparrowdo::Core::DSL::Template;
use Sparrowdo::Core::DSL::Directory;
use Sparrowdo::Core::DSL::Bash;

our sub tasks (%args) {

  my $build-dir = %args<build-dir> || die "usage module_run '{ ::?MODULE.^name }' ,%(build-dir => dir)";

  directory "$build-dir/.cache";
  directory "$build-dir/files";

  my $cfg = %args<configuration> || 'debug';
  template-create "$build-dir/.cache/build.yaml.sample", %(
    source => ( slurp %?RESOURCES<build.yaml> ),
    variables => %( 
      vs_version => %args<vs-version> || '15.0',
      display_name => %args<display-name> || "Build solution %args<solution> for $cfg",
      solution => %args<solution> || '"**\*.sln"',
      platform => %args<platform> || 'x86',
      configuration => $cfg ,
      restore_solution => %args<restore-solution> || '"**\*.sln"',
      skip_nuget_install => %args<skip-nuget-install>,
      skip_nuget_restore => %args<skip-nuget-restore>,
      test_assemblies => %args<test-assemblies>,
      publish_symbols => %args<publish-symbols>,
    )
  );

  bash "cat $build-dir/.cache/build.yaml.sample >> $build-dir/build.yaml"

}


