# Sparrowdo::VSTS::YAML:Solution

Sparrowdo module to generate VSTS yaml steps to build solution files.

    $ cat sparrowfile

    module_run "VSTS::YAML::Solution", %(
      vs-version  => '15.0', # visual  studio version, default value
      build-dir => ".build",
      solution => "app.sln", # path to solution file, default is "**\*.sln"
      platform => "x86",
      configuration => "debug",
      restore-solution => "app.sln", # path to NugetRestore solution file
      skip-nuget-install => True, # don't install nuget cli
      test-assemblies => True, # run tests, default value is False
      publish-symbols => Fasle, # publish symbols, this is default value
    );

    $ sparrowdo --local_mode --no_sudo

# Author

Alexey Melezhik

