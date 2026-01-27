let
  plumbing = import ./plumbing;

  load-attributes =
    { env, pkgs }: ((plumbing.attribute-loader { inherit env; }) // { inherit pkgs; });
in
{
  inherit (plumbing) attribute-loader;
  starter = import ./starter.nix;
  zolaScriptsBuilder = import ./zola.nix { scriptsBuilder = plumbing.scriptsBuilderFactory; };

  scriptBuilders = rec {
    astro = import ./astro.nix { scriptsBuilder = plumbing.scriptsBuilderFactory; };
    nextjs = import ./nextjs.nix { scriptsBuilder = plumbing.scriptsBuilderFactory; };

    withEnv = {
      astro = { env, pkgs }: astro load-attributes { inherit env pkgs; };
      nextjs = { env, pkgs }: nextjs load-attributes { inherit env pkgs; };
    };
  };
}
