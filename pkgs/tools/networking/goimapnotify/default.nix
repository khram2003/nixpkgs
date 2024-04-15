{ buildGoModule, fetchFromGitLab, lib, runtimeShell }:

buildGoModule rec {
  pname = "goimapnotify";
  version = "2.3.12";

  src = fetchFromGitLab {
    owner = "shackra";
    repo = "goimapnotify";
    rev = version;
    sha256 = "sha256-H1psA73ZBz4ZCFWGpiAXQ3bDLVH3jPnyOvPtUdsO6BA=";
  };

  vendorHash = "sha256-DphGe9jbKo1aIfpF5kRYNSn/uIYHaRMrygda5t46svw=";

  postPatch = ''
    for f in command.go command_test.go; do
      substituteInPlace $f --replace '"sh"' '"${runtimeShell}"'
    done
  '';

  meta = with lib; {
    description =
      "Execute scripts on IMAP mailbox changes (new/deleted/updated messages) using IDLE";
    homepage = "https://gitlab.com/shackra/goimapnotify";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ wohanley rafaelrc ];
    mainProgram = "goimapnotify";
  };
}
