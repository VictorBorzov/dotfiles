let
  vb = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH05BqQ2xaOBKnwpBoBmCpL5DSVVF8W2D5Vz4/2MoKsN";
in
{
  syncthing.publicKeys = [ vb ];
}
