{
  description = "A development environment w/ figlet";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      allPackages = with pkgs; [
        awscli
        bash-completion
        bat
        curl
        expect
        eza
        file
        fzf
        gcc
        git
        git-extras
        gnome-tweaks
        httpie
        jq
        lua
        luarocks
        maven
        neovim
        nodejs_18 # Node.js 18, plus npm, npx, and corepack
        python3
        python312Packages.pip
        ripgrep
        slides
        starship
        stow
        tmux
        wget
        xsel
        zoxide
      ];
    in
    {
      packages = {
        ${system}.default =
          # Define a package environment as a profile
          pkgs.buildEnv {
            name = "ken-profile";
            paths = allPackages;
          };
      };

      devShell = {
        ${system} = nixpkgs.legacyPackages.${system}.mkShell {
          buildInputs = allPackages;
        };
      };
    };
}
