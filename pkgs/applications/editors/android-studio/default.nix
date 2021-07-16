{ callPackage, makeFontsConf, gnome2, buildFHSUserEnv }:

let
  mkStudio = opts: callPackage (import ./common.nix opts) {
    fontsConf = makeFontsConf {
      fontDirectories = [];
    };
    inherit (gnome2) GConf gnome_vfs;
    inherit buildFHSUserEnv;
  };
  stableVersion = {
    version = "4.2.1.0"; # "Android Studio 4.2.1"
    build = "202.7351085";
    sha256Hash = "074y6i0h8zamjgvvs882im44clds3g6aq8rssl7sq1wx6hrn5q36";
  };
  betaVersion = {
    version = "2020.3.1.20"; # "Android Studio Arctic Fox (2020.3.1) Beta 5"
    sha256Hash = "0swcsjx29ar4b0c8yhbynshqdn2sv94ga58h2nrc99927vp17g85";
  };
  latestVersion = { # canary & dev
    version = "2021.1.1.3"; # "Android Studio Bumblebee (2021.1.1) Canary 3"
    sha256Hash = "1n8iahaqhmzvpps9vhv93n3yabb26vl78yndd6gid028r8r90y4x";
  };
in {
  # Attributes are named by their corresponding release channels

  stable = mkStudio (stableVersion // {
    channel = "stable";
    pname = "android-studio";
  });

  beta = mkStudio (betaVersion // {
    channel = "beta";
    pname = "android-studio-beta";
  });

  dev = mkStudio (latestVersion // {
    channel = "dev";
    pname = "android-studio-dev";
  });

  canary = mkStudio (latestVersion // {
    channel = "canary";
    pname = "android-studio-canary";
  });
}
