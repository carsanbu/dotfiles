require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
	function(server_name)
		require("lspconfig")[server_name].setup({})
	end,
}
require('lint').linters_by_ft = {
  markdown = {'markdownlint-cli2'},
}

-- Guardar historial para FZF (Ctrl+P, Ctrl+N para avanzar/retroceder)
vim.g.fzf_history_dir = '~/.local/share/fzf-history'
-- Búsqueda libre: te deja escribir el término
vim.keymap.set('n', '<leader>a', ':Ag<CR>', { desc = 'Buscar en proyecto' })

-- Búsqueda con la palabra bajo el cursor, lista para editar antes de confirmar
vim.keymap.set('n', '<leader>aw', ':Ag <C-r><C-w><CR>', { desc = 'Buscar palabra bajo cursor' })
