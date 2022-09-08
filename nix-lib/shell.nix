{ lib, bash-completion }:

{
  # Load click exe bash completions right from your shell hook.
  # Use some temporary directory in order to do so.
  # Exports `XDG_DATA_DIRS` to make this available as part of your env.
  # This has been tested to work on linux machines.
  loadClickExesBashCompletion = clickExes: ''
    click_exes=( ${lib.strings.concatStringsSep " " clickExes} )

    # Install click application bash completions.
    bash_compl_tmp_root_dir=$(mktemp -d)

    bash_completion_dir="$bash_compl_tmp_root_dir/share/bash-completion/completions"
    mkdir -p "$bash_completion_dir"
    for e in "''${click_exes[@]}"; do
      click_complete_env_var_name="_$(echo "$e" | tr "[a-z-]" "[A-Z_]")_COMPLETE"
      env "''${click_complete_env_var_name}=bash_source" "$e" > "$bash_completion_dir/$e" \
        || true
      # Because of the above, check that we got some completion code in the file.
      cat "$bash_completion_dir/$e" | grep "$click_complete_env_var_name" > /dev/null
    done

    __prefix_path() {
      local varname="''${1?}"
      local -n old_value="''${1?}"
      local prefixed_value="''${2?}"
      if [[ -z "''${old_value}" ]]; then
        export "''${varname}=$prefixed_value"
      else
        export "''${varname}=$prefixed_value:''${old_value}"
      fi
    }

    __prefix_path "XDG_DATA_DIRS" "$bash_compl_tmp_root_dir/share"

    reload_bash_completions() {
      . ${bash-completion}/etc/profile.d/bash_completion.sh
    }

    if ! type _completion_loader > /dev/null; then
      reload_bash_completions
    fi
  '';
}
