{scriptsBuilder}: 
args@{port, dir ? "", pkgs, reserved-name }: 
let 
  zrok-url = "https://${reserved-name}.share.zrok.io";
in
(scriptsBuilder ''
    cwd=$(pwd)
    cd $cwd/${dir}
    # zola serve -p ${port} --interface $(_get-ip) 
    # zola serve -p ${port} --interface $(ip -4 addr show wlo1 | grep -oP '(?<=inet\s)\d+(\.\d+){3}') 
    # zola serve -p ${port} --base-url '${zrok-url}'
    zola serve -p ${port}
    cd $cwd
    '' args)
