let
  scriptsBuilderFactory = import ./plumbing/scripts-builder-factory.nix;
  attribute-loader = import ./plumbing/attribute-loader.nix;
in
{
  inherit attribute-loader;
  starter = import ./starter.nix;
  zolaScriptsBuilder = import ./zola.nix { scriptsBuilder = scriptsBuilderFactory; };

  scriptBuilders = rec {
    astro = import ./astro.nix { scriptsBuilder = scriptsBuilderFactory; };
    nextjs = import ./nextjs.nix { scriptsBuilder = scriptsBuilderFactory; };

    withEnv = {
      astro = config: astro (attribute-loader config);
    };
  };
}
