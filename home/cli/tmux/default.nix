{ self, inputs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    
  };
}
