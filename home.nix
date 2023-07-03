
{ config, pkgs, ... }:
#  nix = {
    # -- snip --
#    package = pkgs.nix;
 #   settings = {
      # -- snip --
  #    substituters = [ "https://cache.nixos.org" "https://tomodachi94.cachix.org" ];
   #   trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "tomodachi94.cachix.org-1:E1WFk+SYPtq3FFO+NvDgsyciIHg8nHxB/z7qNfojxpI=" ];
    #};
 # };
  # Carry on with the rest of the HM configuratio
{
  #overlay
 
   # [...]
   nixpkgs.overlays = [ (final: prev:  {
    openssh = prev.openssh.override {
#      hpnSupport = true;
#      withKerberos = true;
#      kerberos = final.libkrb5;
    };
  }) ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "x";
  home.homeDirectory = "/home/x";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.cargo
    pkgs.gcc
    pkgs.gnumake
    #pkgs.nautilus-gtk3
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
     (pkgs.writeShellScriptBin "my-hello" ''
       echo "Hello, ${config.home.username}!"
     '')
    #pkgs.nyxt
    pkgs.rhythmbox
    pkgs.transmission
    pkgs.sops
    pkgs.sqlite
    pkgs.haskellPackages.keystore
    pkgs.haskellPackages.haskell-language-server
    pkgs.openssl_3
    pkgs.autoreconfHook
    pkgs.pkg-config
    pkgs.firefox
    pkgs.nixos-generators
    pkgs.lsof
    pkgs.netcat-gnu
    pkgs.jekyll
    pkgs.python3Minimal
    pkgs.git
    pkgs.haskell.packages.ghc945.cabal-install
    pkgs.haskellPackages.stack
    pkgs.sbcl
    pkgs.sbclPackages.nyxt
    pkgs.zig
    pkgs.unison
    #pkgs.haskell.packages.ghc945.hsenv
    #pkgs.haskellPackages.hsenv
    pkgs.devbox
    pkgs.zsh
    pkgs.ghc
    pkgs.haskell.packages.ghc945.zlib
    pkgs.zlib
    pkgs.gitlab-runner
    pkgs.python311Packages.python-gitlab
    pkgs.inetutils
    pkgs.dropbear
    pkgs.moreutils
    pkgs.openssh
    pkgs.krb5
    pkgs.darktable
    pkgs.vim
    pkgs.packer
    pkgs.haskellPackages.Agda
    pkgs.haskellPackages.cabal2nix
    pkgs.haskellPackages.niv
    pkgs.ocaml-ng.ocamlPackages.findlib
    pkgs.ocaml-ng.ocamlPackages.dune_3
    pkgs.ocaml-ng.ocamlPackages.merlin
    pkgs.ocaml-ng.ocamlPackages.yojson
    pkgs.ocaml-ng.ocamlPackages.ocaml
    pkgs.opam
    pkgs.ocaml-ng.ocamlPackages.janeStreet.async
    pkgs.cachix
    

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/x/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
     EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  #  imports = builtins.concatMap import [
  #   ./services/gpg-agent
  # ];
  #home-manager.useGlobalPkgs = true;
   programs.emacs = {                              


    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
    ];
   };

  services.gpg-agent = {                          


    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
    
}
