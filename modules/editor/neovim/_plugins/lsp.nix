{ pkgs, ... }:{
  plugins.lsp = {
    enable        = true;
    package       = pkgs.vimPlugins.nvim-lspconfig;
    autoLoad      = false;  # automatically load lsp when neovim starts.
    inlayHints    = false;  # enable lsp inlay-hints globally
    capabilities  = "";     # lua code that modifies inplace the capabilities table
    onAttach      = "";     # lua code to be run when a language server is attached
      # print("LSP started!")
    preConfig     = "";
    postConfig    = "";
    setupWrappers = [];

    servers = {
      ansiblels = {
        enable    = false;
        # package = pkgs.ansible-language-server;   unmaintained
        autostart = false;
      };
      bashls.enable = true;
      nixd = {
        enable    = true;
        package   = pkgs.nixd;
        autostart = true;
        settings = {};    # you can pass your flake options directly here to get auto-completion for your own Nixos/Home Manager
      };
      nil_ls.enable        = true;
      nushell.enable       = true;
      systemd_ls.enabe     = true;
      terraformls.enable   = true;  # hashiCorp
      terraform_lsp.enable = false; # community (less active)
      yamlls = {
        enable    = true;
        autostart = true;
        settings = {
          yaml = {
            schemas = {
              "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.32.1-standalone-strict/all.json" = "/*.k8s.yaml";
            };
          };
        };
      };
      # vimls
      # postgres_lsp
      # bazelrc
      # cssls
      # docker_compose_language_service
      # docker_language_server
      # dockerls
      # gitlab_ci_ls
      # gitlab_duo
      # graphql
      # guile_ls (guix)
      # jinja_lsp
      # jsonls
      # jsonnet_ls
      # just
      # lsp_ai    https://github.com/SilasMarvin/lsp-ai ? mcp-language-server ?
      # lua_ls
      # lua-language-server
      # nginx_language_server
      # pylsp
      # pyright
      # pyright
      # rust_analyzer
      # '';   
    };

    keymaps = {
      diagnostic = {
        # "<leader>j" = "goto_next";
        # "<leader>k" = "goto_prev";
      };
      lspBuf = {
        # K  = "hover";
        # gD = "references";
        # gd = "definition";
        # gi = "implementation";
        # gt = "type_definition";
      };
      silent = false;
      extra = [     # Extra keymaps to register when an LSP is attached. This can be used to customise LSP behaviour, for example with “telescope” or the “Lspsaga” plugin, as seen in the examples
        {
          action = "<CMD>LspStop<Enter>";
          key    = "<leader>lx";
          # mode   = [ "n" "v" ];
        }
        {
          action = "<CMD>LspStart<Enter>";
          key    = "<leader>ls";
        }
        {
          action = "<CMD>LspRestart<Enter>";
          key    = "<leader>lr";
        }
        # {
        #   action = {
        #     __raw = "require('telescope.builtin').lsp_definitions";
        #   };
        #   key = "gd";
        # }
        # {
        #   action = "<CMD>Lspsaga hover_doc<Enter>";
        #   key    = "K";
        # }
      ];
    };

    luaConfig = {
      pre  = null;      # Lua code inserted at the start of the plugin’s configuration
      post = null;      # // end 
    };
  };

  # extra lsp plugins
  # plugins = {
  #   lsp-format.enable = true;
  #   lsp-format-modifications
  #   lsp-lines
  #   lsp-signatures
  #   lsp-status
  #   lspconfig
  #   lspkind
  #   lspsaga
  # };
}
