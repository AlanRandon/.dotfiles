{
  services.tor = {
    enable = true;
    torsocks.enable = true;
    client.enable = true;
    settings = {
      ControlPort = 9051;
    };
  };
}
