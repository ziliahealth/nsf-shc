{ lib, bash-completion }:

{
  # Install click exe bash completions to your
  installClickExesBashCompletion = clickExes: ''
    click_exes=( ${lib.strings.concatStringsSep " " clickExes} )

    # Install click application bash completions.
    bash_completion_dir="$out/share/bash-completion/completions"
    mkdir -p "$bash_completion_dir"
    for e in "''${click_exes[@]}"; do
      click_exe_path="$out/bin/$e"
      wrapProgram "$click_exe_path" --prefix PATH ':' "$program_PATH"
      click_complete_env_var_name="_$(echo "$e" | tr "[a-z-]" "[A-Z_]")_COMPLETE"
      # TODO: For some reason, running this return a non zero (1) status code. This might
      # be a click library bug. Fill one if so.
      env "''${click_complete_env_var_name}=source_bash" "$click_exe_path" > "$bash_completion_dir/$e" || true
      # Because of the above, check that we got some completion code in the file.
      cat "$bash_completion_dir/$e" | grep "$e" > /dev/null
    done
  '';

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
      env "''${click_complete_env_var_name}=source_bash" "$e" > "$bash_completion_dir/$e" \
        || true
      # Because of the above, check that we got some completion code in the file.
      cat "$bash_completion_dir/$e" | grep "$e" > /dev/null
    done

    prefix_path "XDG_DATA_DIRS" "$bash_compl_tmp_root_dir/share"
    reload_bash_completions() {
      . ${bash-completion}/etc/profile.d/bash_completion.sh
    }

    if ! type _completion_loader > /dev/null; then
      reload_bash_completions
    fi
  '';
}
