{
  description = "example-tool - Example CLI utility";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (system: pkgs: rec {
        default = example-tool;
        example-tool = pkgs.stdenvNoCC.mkDerivation {
          pname = "example-tool";
          version = "1.0.3";
          src = ./.;

          nativeBuildInputs = [ pkgs.makeWrapper ];

          installPhase = ''
            mkdir -p $out/bin $out/share/zsh/site-functions
            install -D -m 0755 bin/example-tool $out/bin/example-tool
            wrapProgram $out/bin/example-tool \
              --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.coreutils pkgs.jq ]}
            if [ -d completion ]; then
              cp -r completion/* $out/share/zsh/site-functions/ 2>/dev/null || true
            fi
          '';

          meta = {
            description = "Example utility script from sstix-tools";
            mainProgram = "example-tool";
            platforms = pkgs.lib.platforms.unix;
          };
        };
      });

      apps = forAllSystems (system: pkgs: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/example-tool";
        };
      });
    };
}
