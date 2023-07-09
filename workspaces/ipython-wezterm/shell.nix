{pkgs ? import <nixpkgs> {} }:
# to specify matplotlib backend use
(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python311
  ]);

  runScript = ''

  if [ ! -d ".venv" ]; then
   python -m venv .venv
  fi

  source .venv/bin/activate

  export MPLBACKEND="module://matplotlib-backend-wezterm"

  pip install -r requirements.txt
  ipython

  '';

}).env