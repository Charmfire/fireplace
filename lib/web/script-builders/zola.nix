{scriptsBuilder}: 
{port, dir ? "", pkgs}: reserved-name : 
let 
  zrok-url = reserved-name: "https://${reserved-name}.share.zrok.io";
in
(scriptsBuilder ''
    cwd=$(pwd)
    cd $cwd/${dir}
    # zola serve -p ${port} --interface $(_get-ip) 
    # zola serve -p ${port} --interface $(ip -4 addr show wlo1 | grep -oP '(?<=inet\s)\d+(\.\d+){3}') 
    # zola serve -p ${port} --base-url '${zrok-url reserved-name}'
    zola serve -p ${port}
    cd $cwd
    '' {inherit pkgs;} reserved-name)
