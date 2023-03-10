# To ensure this nix-shell is reproducible, we pin the packages index to a commit SHA taken from a channel on https://status.nixos.org/
# This commit is from nixpkgs-unstable, it's somewhere between NixOS 22.11 and the following version
with (import (fetchTarball https://github.com/NixOS/nixpkgs/archive/e0fa1ece2f3929726c9b98c539ad14b63ae8e4fd.tar.gz) {});

let
  # Define variables for packages which are referenced more than once in this nix-shell
  erlang = beam.packages.erlangR25;
  rebar3 = erlang.rebar3;
in
  mkShell {
    buildInputs = [
      # Elixir with Erlang/OTP specified in the `erlang` variable (relying on the package `elixir` alone isn't enough, as the version of Erlang cannot be specified)
      erlang.elixir_1_14
      # The package manager for Erlang
      erlang.hex
      # The build tool for Erlang
      rebar3
      # For the Live Reloading feature in Phoenix
      inotify-tools
      # Locales
      glibcLocales
      # For mix_audit, which runs in the continuous integration - https://github.com/mirego/mix_audit
      git
      # Install certificates to prevent SSL errors
      cacert
      # To deploy on https://fly.io
      flyctl
    ];

    shellHook = ''
      # Set LANG for locales, otherwise it is unset when running "nix-shell --pure"
      export LANG="C.UTF-8"

      # Remove duplicate commands from Bash shell command history
      export HISTCONTROL=ignoreboth:erasedups

      # Keep Mix and Hex data in the project (Be sure to ignore those directories in `.gitignore`)
      export MIX_HOME="$PWD/.nix-mix"
      export HEX_HOME="$PWD/.nix-hex"
      mkdir -p "$MIX_HOME" "$HEX_HOME"
      # Put executables from Mix and Hex directories in $PATH
      export PATH="$MIX_HOME/bin:$MIX_HOME/escripts:$HEX_HOME/bin:$PATH"

      # Persist history of the IEx (Elixir) and erl (Erlang) shells
      export ERL_AFLAGS="-kernel shell_history enabled"

      # Set the path to the rebar3 package from Nix
      mix local.rebar --if-missing rebar3 ${rebar3}/bin/rebar3
    '';

    # Without this, there are warnings about LANG, LC_ALL and locales.
    # Many tests fail due those warnings showing up in test outputs too...
    # This solution is from: https://gist.github.com/aabs/fba5cd1a8038fb84a46909250d34a5c1
    LOCALE_ARCHIVE = "${glibcLocales}/lib/locale/locale-archive";
  }
