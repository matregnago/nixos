{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        clangd.enable = true;
        nixd.enable = true;
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
          settings = {
            checkOnSave = true;
          };
        };
        ts_ls = {
          enable = true;
          autostart = true;
          filetypes = [
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
          ];
          extraOptions = {
            settings = {
              javascript = {
                inlayHints = {
                  includeInlayEnumMemberValueHints = true;
                  includeInlayFunctionLikeReturnTypeHints = true;
                  includeInlayFunctionParameterTypeHints = true;
                  includeInlayParameterNameHints = "all";
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                  includeInlayPropertyDeclarationTypeHints = true;
                  includeInlayVariableTypeHints = true;
                  includeInlayVariableTypeHintsWhenTypeMatchesName = true;
                };
              };
              typescript = {
                inlayHints = {
                  includeInlayEnumMemberValueHints = true;
                  includeInlayFunctionLikeReturnTypeHints = true;
                  includeInlayFunctionParameterTypeHints = true;
                  includeInlayParameterNameHints = "all";
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                  includeInlayPropertyDeclarationTypeHints = true;
                  includeInlayVariableTypeHints = true;
                  includeInlayVariableTypeHintsWhenTypeMatchesName = true;
                };
              };
            };
          };
        };
      };
    };
  };
}
