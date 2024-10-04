{ config, pkgs, ... }:

let
  dokuPkgs = import ./pkgs.nix { inherit pkgs; };
in

with dokuPkgs;
{
  imports = [
    ../../modules/common.nix
    ../../modules/nixos-container.nix
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 ];
  };

  services.dokuwiki.sites."wiki.realraum.at" = {
    enable = true;
    templates = [ dokuwiki-template-bootstrap3 ];
    plugins = [ dokuwiki-plugin-move dokuwiki-plugin-include dokuwiki-plugin-discussion dokuwiki-plugin-pagelist dokuwiki-plugin-tag dokuwiki-plugin-wrap dokuwiki-plugin-multiorphan dokuwiki-plugin-diagram dokuwiki-plugin-icons ];
    package = dokuwiki-with-userstyle;

    settings = {
      template = "bootstrap3";
      # tpl.mindthedark.autoDark = true;
      userewrite = true;
      # baseurl = "https://realraum.at/wiki/";
      baseurl = "http://wiki.realraum.at";
      useacl = true;

      title = "realraum";
      start = "realraum";
      tagline = "Hackerspace in Graz";
      sidebar = "sidebar";
      license = "cc-by-sa";
      recent = 50;
      recent_days = 21;
      breadcrumbs = 0;
      fullpath = true;
      dformat = "%Y-%m-%d %H:%M";
      sneaky_index = 1;
      passcrypt = "bcrypt";
      superuser = "@admin";
      disableactions = "register";
      mailguard = "hex";
      htmlok = true;
      mailfrom = "noreply@wiki.realraum.at";
      sitemap = 5;
      dnslookups = false;
      plugin.move.allowrename = "@admin,@member";
      plugin.include.noheader = true;
      plugin.include.showfooter = false;
      plugin.include.showdate = false;
      plugin.include.showuser = false;
      plugin.include.showcomments = false;
      plugin.include.showlinkbacks = false;
      plugin.include.doindent = false;
      plugin.discussion.allowguests = false;
      plugin.discussion.urlfield = true;
      plugin.discussion.addressfield = true;
      plugin.discussion.userealname = false;
      plugin.discussion.visibilityButton = true;
      plugin.markdownextra.frontmatter = true;
      tpl.bootstrap3.bootswatchTheme = "paper";
      tpl.bootstrap3.showThemeSwitcher = false;
      tpl.bootstrap3.sidebarPosition = "left";
      tpl.bootstrap3.rightSidebar = "";
      tpl.bootstrap3.semantic = true;
      tpl.bootstrap3.schemaOrgType = "TechArticle";
      tpl.bootstrap3.showDiscussion = true;
      tpl.bootstrap3.showBadges = false;
      tpl.bootstrap3.showLandingPage = false;
      tpl.bootstrap3.landingPages = "realraum";
      tpl.bootstrap3.showUserHomeLink = false;
      tpl.bootstrap3.fluidContainer = false;
      tpl.bootstrap3.fluidContainerBtn = false;
      plugin.pagelist.style = "table";
      plugin.pagelist.showdate = "2";
      plugin.pagelist.showuser = "2";
      plugin.pagelist.showdesc = "160";
      plugin.pagelist.showtags = "1";
      plugin.tag.sortkey = "mdate";
      plugin.tag.sortorder = "descending";
      plugin.ckgdoku.smiley_as_text = true;
      plugin.ckgdoku.scayt_lang = "German/de_DE";
      plugin.ckgdoku.duplicate_notes = true;
      plugin.ckgdoku.dw_priority = true;
      plugin.ckgdoku.htmlblock_ok = true;
      plugin.ckgdoku.dblclk = "off";
      plugin.ckgdoku.preserve_enc = true;
      plugin.ckgdoku.rel_links = true;
      plugin.ckgdoku.gui = "moono-lisa";

		};
  };
}
