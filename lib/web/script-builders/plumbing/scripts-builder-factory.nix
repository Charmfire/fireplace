server-cmd:
{ pkgs }:
let 
  kernel = import ../../../kernel { };
in
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
}