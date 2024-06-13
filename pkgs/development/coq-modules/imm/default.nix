{ lib, mkCoqDerivation, which, coq
  , hahn, hahnExt, promising-lib, coqhammer
  , version ? null }:

with lib; mkCoqDerivation {
  pname = "imm";
  owner = "weakmemory";
  domain = "github.com";

  inherit version;
  defaultVersion = with versions; switch coq.coq-version [
    ## Example of possible dependencies
    # { case = range "8.13" "8.14"; out = "1.2.0"; }
    ## other predicates are `isLe v`, `isLt v`, `isGe v`, `isGt v`, `isEq v` etc
  ] null;

  ## Declare existing releases
  ## leave sha256 empty at first and then copy paste
  ## the resulting sha given by the error message
  # release."1.1.1".sha256 = "";
  ## if the tag is not exactly the version number you can amend like this
  # release."1.1.1".rev = "v1.1.1";
  ## if a consistent scheme gives the tag from the release number, you can do like this:
  # releaseRev = v: "v${v}";

  ## Add dependencies in here. In particular you can add
  ## - arbitrary nix packages (you need to require them at the beginning of the file)
  ## - Coq packages (require them at the beginning of the file)
  ## - OCaml packages (use `coq.ocamlPackages.xxx`, no need to require them at the beginning of the file)
  propagatedBuildInputs = [hahn hahnExt promising-lib coqhammer];

  dontConfigure = true;
  extraInstallFlags = ["-f" "Makefile.coq"]; 

  meta = {
    description = "Intermediate Memory Model (IMM) and compilation correctness proofs for it";
    maintainers = with maintainers; [ anlun ];
    license = licenses.mit;
  };
}
