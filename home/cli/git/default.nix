{ self, inputs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Victor Borzov";
    userEmail = "borzov.vk@protonmail.com";

    ignores = [
      ".idea/"
      ".helix/"
    ];
    delta = {
      enable = true;
      options = {
        # use n and N to move between
        navigate = true;
        light = false;
        features = "decorations";
        line-numbers = true;
        side-by-side = true;
        interactive = {
          keep-plus-minus-markers = false;
        };
        decorations = {
          commit-decoration-style = "blue ol";
          commit-style = "raw";
          file-style = "omit";
          hunk-header-decoration-style = "blue box";
          hunk-header-file-style = "red";
          hunk-header-line-number-style = "\"#067a00\"";
          hunk-header-style = "file line-number syntax";
          line-numbers-left-format = "";
          line-numbers-right-format = "│ ";
        };
      };
    };
    includes = [
      {
        condition = "hasconfig:remote.*.url:ssh://git@bitbucket.ap-team.ru*/**";
        contents = {
          user.email = "borzov@ap-team.ru";
        };
      }
    ];
    extraConfig = {
      diff.colorMoved = "default";

      merge = {
        conflict = "style";
        conflictstyle = "diff3";
      };

      mergetool = {
        prompt = false;
      };
      
      core = {
        editor = "hx";
      };
    };
  };
}
