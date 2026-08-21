local data_dir = vim.fn.stdpath('data') .. '/site'
local plug_path = data_dir .. '/autoload/plug.vim'

if vim.fn.empty(vim.fn.glob(plug_path)) > 0 then
  vim.fn.system({
    'curl', '-fLo', plug_path, '--create-dirs',
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  })
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

vim.cmd([[
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/colorizer'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" Plug 'SirVer/ultisnips', {'for': ['sh', 'python', 'markdown', 'c']}
" Plug 'honza/vim-snippets', {'for': ['sh', 'python', 'markdown', 'c']}
Plug 'ervandew/supertab'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
"Plug 'vimwiki/vimwiki'
Plug 'lervag/wiki.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'eslint/eslint'
Plug 'jxnblk/vim-mdx-js'
Plug 'preservim/tagbar'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-lint'
Plug 'rshkarin/mason-nvim-lint'

call plug#end()
]])

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", },
  automatic_enable = true,
})
require('lint').linters_by_ft = {
  markdown = {'markdownlint-cli2'},
}

-- Guardar historial para FZF (Ctrl+P, Ctrl+N para avanzar/retroceder)
vim.g.fzf_history_dir = '~/.local/share/fzf-history'
-- Búsqueda libre: te deja escribir el término
vim.keymap.set('n', '<leader>a', ':Ag<CR>', { desc = 'Buscar en proyecto' })

-- Búsqueda con la palabra bajo el cursor, lista para editar antes de confirmar
vim.keymap.set('n', '<leader>aw', ':Ag <C-r><C-w><CR>', { desc = 'Buscar palabra bajo cursor' })
