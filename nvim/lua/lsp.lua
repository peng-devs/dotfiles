-- lsp
require("mason").setup()
require("mason-lspconfig").setup()
local lsp = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("mason-lspconfig").setup_handlers {
  -- automatic lsp config setup
  function(server_name)
    local config = {
      capabilities = capabilities
    }

    if server_name == 'svelte' then
      config.settings = {
        svelte = {
          plugin = {
            svelte = {
              compilerWarnings = {
                ['unused-export-let'] = 'ignore',
                ['a11y-click-events-have-key-events'] = 'ignore',
                ['a11y-mouse-events-have-key-events'] = 'ignore',
              }
            }
          }
        }
      }
    end

    if server_name == 'sumneko_lua' then
      config.settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    end

    lsp[server_name].setup(config)
  end,
}

-- null-ls
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local null_ls = require("null-ls")
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.prettierd.with {
      extra_filetypes = { 'svelte', 'toml' },
    },
  },
  -- format on saving
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(c)
              return c.name == 'null-ls'
            end
          })
        end,
      })
    end
  end,
}

-- treesitter
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 1
vim.opt.foldenable = false
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'help',
    'vim',
    'lua',
    'rust',
    'javascript',
    'typescript',
    'html',
    'css',
    'svelte',
    'make',
    'markdown',
    'toml',
    'json',
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

-- trouble
require('trouble').setup {
  auto_fold = false,
  action_keys = {
    close = "<esc>",
    cancel = "q",
  }
}
-- vim.api.nvim_set_hl(0, 'TroubleError', { fg = 'red', ctermfg = 'red' })
for _, name in pairs { 'Error', 'Warn', 'Hint', 'Info' } do
  local hl = 'DiagnosticSign' .. name
  vim.fn.sign_define(hl, { text = '|', texthl = hl })
  vim.api.nvim_set_hl(0, 'DiagnosticVirtualText' .. name, { link = hl })
end

-- snippet
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.add_snippets('svelte', {
  luasnip.snippet({
    trig = 's-script-ts',
    name = 'svelte-script-typescript-tag',
    dscr = 'add a ts script to your svelte file'
  }, {
    luasnip.text_node({'<script lang="ts">', '\t'}),
    luasnip.insert_node(0, '// your script goes here'),
    luasnip.text_node({'', '</script>'}),
  }),
  luasnip.snippet({
    trig = 's-style-postcss',
    name = 'svelte-style-postcss-tag',
    dscr = 'add postcss styles to your svelte file'
  }, {
    luasnip.text_node({'<style lang="postcss">', '\t'}),
    luasnip.insert_node(0, '/* your styles go here */'),
    luasnip.text_node({'', '</style>'}),
  })
})

-- nvim-cmp
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  },
  formatting = {
    format = require('lspkind').cmp_format {
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
    }
  }
}
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
cmp.event:on(
  'confirm_done',
  require('nvim-autopairs.completion.cmp').on_confirm_done()
)
