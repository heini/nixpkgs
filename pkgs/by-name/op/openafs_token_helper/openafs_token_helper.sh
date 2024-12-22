#!/run/current-system/sw/bin/bash

# Try to get AFS tokens before running systemd --user
if [[ -n ${UID} && ${UID} -ge 1000 && -x /run/current-system/sw/bin/klist ]] && /run/current-system/sw/bin/klist -s
then
  export KRB5CCNAME="KEYRING:persistent:${UID}"
  /run/current-system/sw/bin/aklog
fi
