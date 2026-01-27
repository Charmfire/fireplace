let
  kernel = import ../../kernel { };
  scriptsBuilder =
    server-cmd:
    { pkgs }:
    reserved-name: {
      qr.exec = "qrencode -t ANSIUTF8 'https://${reserved-name}.share.zrok.io'";
      tunnel.exec = ''
        qr
        echo 'https://${reserved-name}.share.zrok.io'
        zrok share reserved ${reserved-name} --headless
      '';

      # HELPERS
      _get-ip.exec = ''
        #!${pkgs.bash}
        ip -4 addr show wlo1 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'
      '';

      server.exec = server-cmd;
      dev.exec = (kernel.script-parts.parallel-run "server" "tunnel");
    };

  attribute-loader = import ./plumbing/attribute-loader.nix;
in
{
  inherit attribute-loader;
  starter = import ./starter.nix;
  zolaScriptsBuilder = import ./zola.nix { inherit scriptsBuilder; };

  scriptBuilders = rec {
    astro = import ./astro.nix { inherit scriptsBuilder; };
    nextjs = import ./nextjs.nix { inherit scriptsBuilder; };

    withEnv = {
      astro = config: astro (attribute-loader config);
    };
  };
}
