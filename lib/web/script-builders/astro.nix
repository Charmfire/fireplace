{scriptsBuilder}: 
{port, pkgs, ...} : (scriptsBuilder ''
    pnpm dev --port ${port} --host
    '' {inherit pkgs;})
