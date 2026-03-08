{ self, inputs, ... }:
{
  programs.git = {
    enable = true;

    ignores = [
      ".idea/"
      ".helix/"
    ];
    settings = {
      user = {
        name = "Victor Borzov";
        email = "borzov.vk@protonmail.com";
      };

      diff.colorMoved = "default";

      merge = {
        conflict = "style";
        conflictstyle = "diff3";
      };

      mergetool = {
        prompt = false;
      };
      
      core = {
        editor = "emacsclient -r";
      };
    };
  };
}
