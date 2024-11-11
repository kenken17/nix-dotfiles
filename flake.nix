{
  description = "A development environment w/ figlet";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Specify the channel
  };

  outputs = { self, nixpkgs }:
    let
      systemLinux = "x86_64-linux";
      systemMac = "aarch64-darwin";

      linuxPackages = pkgs: [
        pkgs.htop
        pkgs.strace
      ];

      darwinPackages = pkgs: [
        pkgs.gawk
      ];

      commonPackages = pkgs: [
        pkgs.awscli
        pkgs.bash-completion
        pkgs.bat
        pkgs.curl
        pkgs.expect
        pkgs.eza
        pkgs.file
        pkgs.fzf
        pkgs.gcc
        pkgs.git
        pkgs.git-extras
        pkgs.gnome-tweaks
        pkgs.httpie
        pkgs.jq
        pkgs.lua
        pkgs.luarocks
        pkgs.maven
        pkgs.neovim
        pkgs.nodejs_18 # Node.js 18, plus npm, npx, and corepack
        pkgs.python3
        pkgs.python312Packages.pip
        pkgs.ripgrep
        pkgs.slides
        pkgs.starship
        pkgs.stow
        pkgs.tmux
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
