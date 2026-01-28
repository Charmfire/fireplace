{scriptsBuilder}: 
args@{port, pkgs, ...} : (scriptsBuilder ''
    pnpm dev --port ${port}
    '' args)