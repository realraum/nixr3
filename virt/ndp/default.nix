{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "ndp-proxy";
  version = "unstable-2023-05-02";

  src = fetchFromGitHub {
    owner = "setaou";
    repo = "ndp-proxy";
    rev = "ab5b1ace44910ecab5eccab020af3016a5f9ecbe";
    hash = "sha256-8QcCIk5fDvsDuuznEDoL3Cs+2e3OeL9rlOy9DZWgHgA=";
  };

  postPatch = ''
    mkdir -p "$out/bin"
    sed "s|/usr/sbin|$out/bin|g" -i Makefile
    sed "s|-o root -g root||g" -i Makefile
  '';

  meta = with lib; {
    description = "NDP Proxy";
    homepage = "https://github.com/setaou/ndp-proxy";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ ];
    mainProgram = "ndp-proxy";
    platforms = platforms.all;
  };
}
