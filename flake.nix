{
  description = "A development environment w/ figlet";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }: {
    packages = {
      x86_64-linux.default =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
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

        # Define a package environment as a profile
        pkgs.buildEnv {
          name = "ken-profile";
          paths = allPackages;
        };
    };

    devShells =
      let
        systemLinux = "x86_64-linux";
        systemMac = "aarch64-darwin";
      in
      {
        ${systemLinux}.default = nixpkgs.legacyPackages.${systemLinux}.mkShell {
          buildInputs =
            let
              pkgs = nixpkgs.legacyPackages.${systemLinux};
            in
            [
              pkgs.ripgrep
            ];
        };

        ${systemMac} = nixpkgs.legacyPackages.${systemMac}.mkShell {
          buildInputs =
            let
              pkgs = nixpkgs.legacyPackages.${systemLinux};
            in
            [
              pkgs.ripgrep
            ];
        };
      };
  };
}
