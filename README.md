Readme
======

A nix library to simplify packaging shell completions and providing a test
environment for these completions.

Currently used as part of [nixos-secure-factory], hence the `nsf-` prefix.
However, this can perfectly be used as a standalone library / tool.

[nixos-secure-factory]: https://github.com/jraygauthier/nixos-secure-factory


Features
--------


Script fragments providing the ability to:

 -  Install to `$out` the bash completion for a set of named [click] executable.
 -  Build / export `XDG_DATA_DIRS` for set of nix packages. This allow to
    make available bash completions from a nix shell provided that
    the *dynamic bash completion loader* from the [bash-completion] package
    has been sourced.
 -  Ensure that the *dynamic bash completion loader* from the [bash-completion]
    package is sourced.

[bash-completion]: https://github.com/scop/bash-completion


Contributing
------------

Contributing implies licensing those contributions under the terms of [LICENSE](./LICENSE), which is an *Apache 2.0* license.
