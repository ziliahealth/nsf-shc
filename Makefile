MKF_CWD := $(shell pwd)

.PHONY: all clean release

all: release

clean:
	rm -f ./result*

release:
	nix eval --show-trace --raw \
	  '(builtins.toString (builtins.isAttrs ((import ./release.nix {}).nix-lib)))'
	nix eval --show-trace --raw \
	  '(builtins.toString (builtins.isAttrs ((import ./release.nix {}).nix-lib.nsfShC)))'
	nix eval --show-trace --raw \
	  '(builtins.toString (builtins.isAttrs ((import ./release.nix {}).nix-lib.nsfShC.env)))'
	nix eval --show-trace --raw \
	  '(builtins.toString (builtins.isAttrs ((import ./release.nix {}).nix-lib.nsfShC.pkg)))'
	nix eval --show-trace --raw \
	  '(builtins.toString (builtins.isAttrs ((import ./release.nix {}).nix-lib.nsfShC.shell)))'
	nix eval --show-trace --raw \
	  '(builtins.toString (builtins.isAttrs ((import ./release.nix {}).nix-lib.shComp)))'