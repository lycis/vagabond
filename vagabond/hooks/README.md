# Hooks

This directory holds any hook scripts you might want to use. To add a 
new function that handles a specific hook you need to place it within
a Ruby script within this folder.

See `osconfig.rb` as example.

## Available Hooks
This section lists all currently available hooks by their entry point.

### Operating System
These hooks are available from within the `os` configuration.

**configuration**: called during the configuration of a machine. e.g. can
be used to inject any operating system specific Vagrant configuration
