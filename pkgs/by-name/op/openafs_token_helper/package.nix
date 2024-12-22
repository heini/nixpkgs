{
  lib,
  stdenv,
  bash,
  krb5,
  openafs,
  systemd,
  writeTextFile,
}:
stdenv.mkDerivation rec {
  pname = "openafs_token_helper";
  version = "1.0";
 
  dontUnpack = true; 
  buildInputs = [ bash krb5 openafs ];

  installPhase = ''
    mkdir -p $out/libexec
    cp $token_helper/libexec/openafs_token_helper.sh $out/libexec
  '';

  meta = with lib; {
    description = "Helper script to get AFS tokens before running \"systemd --user\"";
    license = licenses.gpl3Plus;
    longDescription = ''
      This is a little helper script to get AFS tokens when before running "systemd --user", in order to make modern desktop environments like KDE Plasma or Gnome work in case the user's ${HOME} is in AFS.
    '';
    maintainers = with lib.maintainers; [ heini ];
    platforms = platforms.linux;
  };
  
  token_helper = writeTextFile {
    destination = "/libexec/openafs_token_helper.sh";
    executable = true;
    name = "openafs_token_helper.sh";
    text = builtins.readFile ./openafs_token_helper.sh;
  };
}
