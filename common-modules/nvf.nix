{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    vim            
  ];
  environment.variables = {
    EDITOR = "nvim";
    RANGER_LOAD_DEFAULT_RC = "FALSE";
    XKB_DEFAULT_LAYOUT = "us";
    GSETTINGS_BACKEND = "keyfile";
  };
        
        
  programs.nvf = { # enable nvf
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        languages = {
          enableLSP = true;
          enableTreesitter = true;
          nix.enable = true;
          python.enable = true;
          rust.enable = true;
        };
      };
    };
  };
}
