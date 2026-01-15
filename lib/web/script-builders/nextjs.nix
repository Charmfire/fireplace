{scriptsBuilder}: 
{port, pkgs} : (scriptsBuilder ''
    pnpm dev --port ${port}
    '' {inherit pkgs;})