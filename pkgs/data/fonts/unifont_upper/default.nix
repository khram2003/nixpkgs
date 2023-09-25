{ lib, stdenvNoCC, fetchurl }:

stdenvNoCC.mkDerivation rec {
  pname = "unifont_upper";
  version = "15.1.01";

  src = fetchurl {
    url = "mirror://gnu/unifont/unifont-${version}/${pname}-${version}.otf";
    hash = "sha256-+aSVF8taBuAmkrQDvCH5bqdnEo21LwidMSYaiWjTrOg=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 $src $out/share/fonts/opentype/unifont_upper.otf

    runHook postInstall
  '';

  meta = with lib; {
    description = "Unicode font for glyphs above the Unicode Basic Multilingual Plane";
    homepage = "https://unifoundry.com/unifont/";

    # Basically GPL2+ with font exception.
    license = "https://unifoundry.com/LICENSE.txt";
    maintainers = [ maintainers.mathnerd314 maintainers.vrthra ];
    platforms = platforms.all;
  };
}
