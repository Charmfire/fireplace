let 
  kernel = import ../kernel {};
  zrok-url = reserved-name: "https://${reserved-name}.share.zrok.io";
in
rec {
  scriptsBuilder = server-cmd: { pkgs }: reserved-name:
  {
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

  # pnpmScriptsBuilder = port: (scriptsBuilder "pnpm dev --port ${port}" port)
  zolaScriptsBuilder = {port, dir ? "", pkgs}: reserved-name : (scriptsBuilder ''
    cwd=$(pwd)
    cd $cwd/${dir}
    # zola serve -p ${port} --interface $(_get-ip) 
    # zola serve -p ${port} --interface $(ip -4 addr show wlo1 | grep -oP '(?<=inet\s)\d+(\.\d+){3}') 
    # zola serve -p ${port} --base-url '${zrok-url reserved-name}'
    zola serve -p ${port}
    cd $cwd
    '' {inherit pkgs;} reserved-name);
    
  astroScriptsBuilder = {port, pkgs} : (scriptsBuilder ''
    pnpm dev --port ${port} --host
    '' {inherit pkgs;});

  # STARTER
  starter = { port }: {
    zrok-reserve.exec = "zrok reserve public ${port}";
  };

}