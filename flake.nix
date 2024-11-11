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

      commonPackages = [
        # "cowsay"
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
      ];
    in
    {
      # packages = {
      #   x86_64-linux.default =
      #     # Define a package environment as a profile
      #     pkgsLinux.buildEnv {
      #       name = "ken-profile";
      #       paths = resolvePackages pkgsLinux;
      #     };
      # };

      # Development shell for Linux
      devShell.x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;

          linuxPackages = [
            pkgs.htop
            pkgs.strace
          ];
        in
        pkgs.mkShell {
          buildInputs = commonPackages pkgs ++ linuxPackages;
        };

      # Define the development shell for macOS
      devShell.aarch64-darwin =
        let
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;

          darwinPackages = [
            pkgs.gawk
          ];
        in
        pkgs.mkShell {
          buildInputs = commonPackages pkgs ++ darwinPackages;
        };
    };
}
