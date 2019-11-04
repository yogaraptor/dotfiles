" == VIM PLUG ================================
call plug#begin('~/.vim/plugged')
"------------------------ COC ------------------------
" coc for tslinting, auto complete and prettier
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" coc extensions
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']
"------------------------ VIM TSX ------------------------
" by default, if you open tsx file, neovim does not show syntax colors
" vim-tsx will do all the coloring for jsx in the .tsx file
Plug 'ianks/vim-tsx'
"------------------------ VIM TSX ------------------------
" by default, if you open tsx file, neovim does not show syntax colors
" typescript-vim will do all the coloring for typescript keywords
Plug 'leafgarland/typescript-vim'
"------------------------ THEME ------------------------
" most importantly you need a good color scheme to write good code :D
Plug 'morhetz/gruvbox'

Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'roman/golden-ratio'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-commentary'
Plug 'dkprice/vim-easygrep'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
Plug 'pangloss/vim-javascript'
Plug 'kristijanhusak/vim-js-file-import'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
Plug 'neoclide/coc.nvim'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-surround'

call plug#end()
set runtimepath^=~/.vim/bundle/ctrlp.vim


" == VIMPLUG END ================================
" == AUTOCMD ================================ 
" by default .ts file are not identified as typescript and .tsx files are not
" identified as typescript react file, so add following
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
" == AUTOCMD END ================================

let mapleader = ','
:colorscheme gruvbox
" Open new splits to right and bottom
set splitright
set splitbelow

" File stuff
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

" Jumping between files/locations
nmap <leader>i <C-o>
nmap <leader>- <C-o>
nmap <leader>o <C-i>
nmap <leader>b :b#<CR>

set background=dark
" Line numbers
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Search
set ignorecase
set smartcase

" Ignore git ignored files when fuzzy finding
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
nmap <leader>p <C-p>

" Switching panes. I rarely have more than two open - using 1w/2w instead of
" l/h means this works with both vertical and horizontal splits
nmap <leader>' <C-w>2w
nmap <leader>; <C-w>1w

" JS Folding (thanks
" https://medium.com/vim-drops/javascript-folding-on-vim-119c70d2e872)
set foldmethod=syntax
set foldcolumn=1
let javascript_fold=1
set foldlevelstart=99

" ALE
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '!!'
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
nmap <leader>f :ALEFix<CR>

" Jump between errors
command Lnext try | lnext | catch | lfirst | catch | endtry
command Lprev try | lprev | catch | llast | catch | endtry
map <C-k> :Lprev<CR>
map <C-j> :Lnext<CR>

" Clear search highlight with escape
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Git
nmap <leader>gb :Gblame<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gdd :Gdiffoff<CR>

" Searching
let g:ackprg = "ag --vimgrep"
nmap <leader>a :Ack! 

" Browsing
nmap <leader>x :Ex<CR>

" Make backspace a little more familiar
set backspace=2

" Show quicklist
nmap <leader>` :copen<CR>

" Prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue Prettier

" Inline git diffs
set updatetime=100
let g:gitgutter_enabled = 1

" COC mappings
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Hide quickfix mapping
nmap <leader><leader>c :ccl<CR>

" LSP setup (thankyouthankyou https://github.com/prabirshrestha/vim-lsp)
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'typescript-language-server',
      \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
      \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx']
      \ })
endif

nmap <leader>. :LspDefinition<CR>

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

" for asyncomplete.vim log
let g:asyncomplete_log_file = expand('~/asyncomplete.log')


"LanguageClient-neovim
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ 'javascript': ['typescript-language-server',  '--stdio'],
    \ 'javascript.jsx': ['typescript-language-server',  '--stdio'],
    \ 'typescript': ['typescript-language-server',  '--stdio'],
    \ 'typescript.tsx': ['typescript-language-server',  '--stdio'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nmap <leader>. :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
