{pkgs, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        line-number = "relative";
        mouse = false;
        shell = ["bash" "-c"];
        color-modes = true;
        bufferline = "multiple";
        auto-save = true;
        soft-wrap.enable = true;

        statusline = {
          left = ["mode" "spinner"];
          center = ["file-name"];
          right = ["diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type"];
          separator = "│";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        whitespace = {
          render = {
            space = "all";
            tab = "all";
            nbsp = "all";
            newline = "none";
          };
          characters = {
            space = "·";
            nbsp = "⍽";
            tab = "→";
            newline = "⏎";
            tabpad = "·"; # Tabs will look like "→···" (depending on tab width)
          };
        };
        indent-guides = {
          render = true;
          character = "┊"; # Some characters that work well: "▏", "┆", "┊", "⸽"
          skip-levels = 1;
        };
        lsp = {
          display-signature-help-docs = false;
        };
        file-picker = {
          hidden = false;
        };
      };

      keys = {
        normal = {
          C-j = ["extend_to_line_bounds" "delete_selection" "paste_after"];
          C-k = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before"];
          space = {
            #w = ":write"
            #q = ":quit"
            f = ["file_picker_in_current_buffer_directory"];
            F = ["file_picker"];
          };
        };
        insert = {
          "C-[" = ["normal_mode"];
        };
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
        }
      ];
    };
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = {};
      };
    };
  };
}
