{
  description = "A development environment w/ figlet";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Specify the channel
  };

  outputs = { self, nixpkgs }:
    let
      systemLinux = "x86_64-linux";
      systemMac = "aarch64-darwin";

      commonPackages = pkgs: [
        pkgs.cowsay
        pkgs.figlet
      ];

      linuxPackages = pkgs: [
        pkgs.htop
        pkgs.strace
      ];

      darwinPackages = pkgs: [
        pkgs.gawk
      ];
      # commonPackages = [
      # "awscli"
      # "bash-completion"
      # "bat"
      # "curl"
      # "expect"
      # "eza"
      # "file"
      # "fzf"
      # "gcc"
      # "git"
      # "git-extras"
      # "gnome-tweaks"
      # "httpie"
      # "jq"
      # "lua"
      # "luarocks"
      # "maven"
      # "neovim"
      # "nodejs_18" # Node.js 18, plus npm, npx, and corepack
      # "python3"
      # "python312Packages.pip"
      # "ripgrep"
      # "slides"
      # "starship"
      # "stow"
      # "tmux"
      # "wget"
      # "xsel"
      # "zoxide"
      # ];
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
