{
  description = "A development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Specify the channel
  };

  outputs = { self, nixpkgs }:
    let
      systemLinux = "x86_64-linux";
      systemMac = "aarch64-darwin";

      linuxPackages = pkgs: [
        # pkgs.docker-buildx
        pkgs.kubectl
        pkgs.gnome-tweaks
        pkgs.xclip
      ];

      darwinPackages = pkgs: [
        # pkgs.aerospace
        pkgs.colima
        pkgs.docker
      ];

      commonPackages = pkgs: [
        pkgs.awscli2
        pkgs.bash-completion
        pkgs.bat
        pkgs.bruno
        pkgs.curl
        pkgs.dbeaver-bin
        pkgs.delta
        pkgs.dive
        pkgs.expect
        pkgs.eza
        pkgs.file
        pkgs.fzf
        pkgs.gcc
        pkgs.git
        pkgs.git-extras
        pkgs.gnused
        pkgs.gradle
        pkgs.gradle-completion
        pkgs.httpie
        pkgs.imagemagick
        pkgs.jq
        pkgs.kind
        pkgs.lua
        pkgs.luarocks
        pkgs.maven
        # pkgs.neovim
        # pkgs.nodejs_18 # Node.js 18, plus npm, npx, and corepack
        # pkgs.python3
        pkgs.python312Packages.pip
        pkgs.ripgrep
        pkgs.slides
        pkgs.starship
        pkgs.stow
        pkgs.temurin-bin
        # pkgs.tmux
        pkgs.wget
        pkgs.xsel
        pkgs.zoxide
      ];
    in
    {
      defaultPackage = {
        # Define a package environment as a profile for Linux
        x86_64-linux =
          let
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
          in
          pkgs.buildEnv {
            name = "ken-profile";
            paths = commonPackages pkgs ++ linuxPackages pkgs;
          };

        # Define a package environment as a profile for macOS
        aarch64-darwin =
          let
            pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          in
          pkgs.buildEnv {
            name = "ken-profile";
            paths = commonPackages pkgs ++ darwinPackages pkgs;
          };
      };

      # Development shell for Linux
      devShell.x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs.mkShell {
          buildInputs = commonPackages pkgs ++ linuxPackages pkgs;
        };

      # Define the development shell for macOS
      devShell.aarch64-darwin =
        let
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        in
        pkgs.mkShell {
          buildInputs = commonPackages pkgs ++ darwinPackages pkgs;
        };
    };
}
