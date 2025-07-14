{
  security.pki = {
    certificateFiles = [      # trusted root certificates in PEM format
      ./mycert.pem
      # "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
    ];
    # caCertificateBlacklist = [
    #   "WoSign"
    #   "WoSign China"
    #   "CA WoSign ECC Root"
    #   "Certification Authority of WoSign G2"
    # ];
    # ca = [ ''
    #     NixOS.org
    #     =========
    #     -----BEGIN CERTIFICATE-----
    #     MIIGUDCCBTigAwIBAgIDD8KWMA0GCSqGSIb3DQEBBQUAMIGMMQswCQYDVQQGEwJJ
    #     TDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0
    #     ...
    #     -----END CERTIFICATE-----
    #   ''
    # ];
    # useCompatibleBundle = true;     # incompatible with certain software stacks, BEGIN CERTIFICATE and no BEGIN TRUSTED CERTIFICATE, which is an OpenSSL specific PEM format
  };
}
