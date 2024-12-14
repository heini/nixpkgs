{ lib, stdenv, fetchurl, pam, libkrb5 }:

stdenv.mkDerivation rec {
  pname = "pam-afs-session";
  version = "2.6";

  src = fetchurl {
    url = "https://archives.eyrie.org/software/afs/pam-afs-session-${version}.tar.gz";
    sha256 = "sha256-v2wqYKB57FORfSaKl9Awc15hiftWkA01xvawGRtd/MU=";
  };

  buildInputs = [ pam libkrb5 ];

  meta = with lib; {
    description = "PAM module intended for use with a Kerberos PAM module to obtain an AFS PAG and AFS tokens on login.";
    homepage = "https://www.eyrie.org/~eagle/software/pam-afs-session/";
    license = licenses.bsd3;
    longDescription = ''
      pam-afs-session is a PAM module that isolates each login in a separate AFS PAG
      (so that they will not trample on each other's AFS tokens) and supports either
      running an external program to obtain AFS tokens from a Kerberos ticket cache
      or using Heimdal's libkafs library. It does not obtain tickets itself and must
      be used in conjunction with a Kerberos PAM module to obtain tokens (setting up
      PAGs can be done without any Kerberos implementations). It provides only the
      setcred and session PAM functions.
    '';
    maintainers = with lib.maintainers; [ heini ];
    platforms = platforms.linux;
  };
}
