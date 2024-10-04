{ pkgs }:

{
  /* dokuwiki-template-realraum = pkgs.stdenv.mkDerivation rec {
    name = "realraum";
    version = "2024-10-03";
    src = pkgs.fetchFromGitHub {
      owner = "realraum";
      repo = "dokuwiki-r3-template";
      rev = version;
      sha256 = "sha256-AiPc3l1ncl3ZeTrSwi85YTPVhfMGmJPtFYaZ6djKN+c=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  }; */

  dokuwiki-template-bootstrap3 = pkgs.stdenv.mkDerivation rec {
    name = "bootstrap3";
    version = "v2024-02-06";
    src = pkgs.fetchFromGitHub {
      owner = "giterlizzi";
      repo = "dokuwiki-template-bootstrap3";
      rev = version;
      sha256 = "sha256-PSA/rHMkM/kMvOV7CP1byL8Ym4Qu7a4Rz+/aPX31x9k=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };

  dokuwiki-plugin-icons = pkgs.stdenv.mkDerivation rec {
    name = "icons";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "giterlizzi";
      repo = "dokuwiki-plugin-icons";
      rev = "master";
      sha256 = "sha256-24TlBUXH1jkAwtBKaxyHiVT0/oyXfL8/q0H0CWkdx94=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };

  dokuwiki-plugin-move = pkgs.stdenv.mkDerivation rec {
    name = "move";
    version = "2024-05-07";
    src = pkgs.fetchFromGitHub {
      owner = "michitux";
      repo = "dokuwiki-plugin-move";
      rev = version;
      sha256 = "sha256-wi9doC1AmC/vBjuooOsh4+hQWdH66MEiIjZdW9e03g0=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };

  dokuwiki-plugin-include = pkgs.stdenv.mkDerivation rec {
    name = "include";
    version = "2023-09-22";
    src = pkgs.fetchFromGitHub {
      owner = "dokufreaks";
      repo = "plugin-include";
      rev = version;
      sha256 = "sha256-PEN0wuLKu6eGYYJ9jB7Kkwn9K2QGXlQw09CfxQ2SSxA=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };

  dokuwiki-plugin-discussion = pkgs.stdenv.mkDerivation rec {
    name = "discussion";
    version = "2017-08-24";
    src = pkgs.fetchFromGitHub {
      owner = "dokufreaks";
      repo = "plugin-discussion";
      rev = version;
      sha256 = "sha256-Eo2aMHyVWlebzaue3ISttC3HqY54ht6jz9r8v6D5ikI=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };

  dokuwiki-plugin-markdownextra = pkgs.stdenv.mkDerivation rec {
    name = "markdownextra";
    version = "2013-01-14";
    src = pkgs.fetchFromGitHub {
      owner = "naokij";
      repo = "dokuwiki-plugin-markdownextra";
      rev = "master";
      sha256 = "sha256-UPLdmOvHUm6heWMwNrmihzhwB7KOVL4SQ0uARtw0Co0=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };

  dokuwiki-plugin-pagelist = pkgs.stdenv.mkDerivation rec {
    name = "pagelist";
    version = "2023-08-27";
    src = pkgs.fetchFromGitHub {
      owner = "dokufreaks";
      repo = "plugin-pagelist";
      rev = version;
      sha256 = "sha256-EHOpghE6ou1sdlGj6zIzRGAVCcwADteQeBW8adwBHpo=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };

  dokuwiki-plugin-tag = pkgs.stdenv.mkDerivation rec {
    name = "tag";
    version = "2023-10-17";
    src = pkgs.fetchFromGitHub {
      owner = "dokufreaks";
      repo = "plugin-tag";
      rev = version;
      sha256 = "sha256-W6p+t2pdThypazx58UsmBvjXovRHage+TdDPrsidXJc=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };

  dokuwiki-plugin-wrap = pkgs.stdenv.mkDerivation rec {
    name = "wrap";
    version = "v2023-08-13";
    src = pkgs.fetchFromGitHub {
      owner = "selfthinker";
      repo = "dokuwiki_plugin_wrap";
      rev = version;
      sha256 = "sha256-my7XW/Blyj6PLZJqs3MX3kRWXpInB913gYZnQ70v9Rs=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };

  dokuwiki-plugin-multiorphan = pkgs.stdenv.mkDerivation rec {
    name = "multiorphan";
    version = "2021-12-20";
    src = pkgs.fetchFromGitHub {
      owner = "i-net-software";
      repo = "dokuwiki-plugin-multiorphan";
      rev = version;
      sha256 = "sha256-ZBPIRQh4ET8R+G0JyKXevfMpaCodLSsvL9zjzqf2C2c=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };

  dokuwiki-plugin-diagram = pkgs.stdenv.mkDerivation {
    name = "diagram";
    version = "2021-02-21";
    src = pkgs.fetchzip {
      url = "http://nikita.melnichenko.name/download.php?q=dokuwiki-diagram-latest.tgz";
      sha256 = "sha256-lgv2gkrCyp9uY/MDZw31wA8SzBLmWTbnTWyfzZHQokI=";
    };
    sourceRoot = ".";
    installPhase = "mkdir -p $out; cp -R * $out/";
  };
}
