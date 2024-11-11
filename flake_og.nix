{
  description = "Nix Dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Systems supported
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # Helper to provide system-specific attributes
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      # Development environment output
      devShells = forAllSystems ({ pkgs }: {
        default = pkgs.mkShell {
          # The Nix packages provided in the environment
          packages = with pkgs; [
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
            starship 
            stow 
            tmux 
            wget 
            xsel
            zoxide
          ];
        };
      });
    };
}
