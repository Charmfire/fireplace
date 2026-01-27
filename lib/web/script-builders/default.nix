let
  plumbing = import ./plumbing;
in
{
  inherit (plumbing) attribute-loader;
  starter = import ./starter.nix;
  zolaScriptsBuilder = import ./zola.nix { scriptsBuilder = plumbing.scriptsBuilderFactory; };

  scriptBuilders = rec {
    astro = import ./astro.nix { scriptsBuilder = plumbing.scriptsBuilderFactory; };
    nextjs = import ./nextjs.nix { scriptsBuilder = plumbing.scriptsBuilderFactory; };

    withEnv = {
      astro = env: astro (plumbing.attribute-loader {inherit env; });
      nextjs = env: nextjs (plumbing.attribute-loader {inherit env; });
    };
  };
}
