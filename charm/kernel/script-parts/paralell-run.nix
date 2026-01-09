cmd1-name: cmd2-name: ''
  ${cmd1-name} | sed 's/^/[${cmd1-name}] /' &
  ${cmd2-name} | sed 's/^/[${cmd2-name}] /' &
  wait
'' 

# FIXME: if used multiple times: support n-th cmd too 
# {cmd1-name, cmd2-name, cmd3-name ? ""} : ''
