{
  description = "DevShell for building and managing NixOS VM images with Terraform and QEMU";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          terraform      # IaC tool to manage infrastructure
          qemu           # For building/testing NixOS VM images
          tmux           # Handy for multitasking sessions
        ];

        shellHook = ''
          echo "🌱 Welcome to the NixOS + Terraform dev environment!"
          echo "Tools available: terraform, qemu, tmux"
          echo "Use 'nix build .#image' if you add an image builder output later."
        '';
      };
    };
}
