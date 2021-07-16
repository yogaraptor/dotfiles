call plug#begin('~/.vim/plugged')
" Color schemes
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Fuzzy-finding of files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
" Show buffers in tabline
Plug 'ap/vim-buftabline'
" Prettier for formatting
Plug 'prettier/vim-prettier'
" ALE for linting
Plug 'w0rp/ale'
Plug 'roman/golden-ratio'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'styled-components/vim-styled-components'
Plug 'moll/vim-bbye'
call plug#end()

" Editor settings
" Relative line numbers (with current line number shown) in insert mode,
" normal numbers in normal mode
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

let g:mapleader=','
set expandtab
set shiftwidth=2
set tabstop=2
set splitright
set splitbelow

" Theming
:colorscheme gruvbox
highlight Comment cterm=italic gui=italic
if (has("termguicolors"))
  set termguicolors
endif
" Highlight active line
set cursorline
" Colour numbers below reference https://github.com/morhetz/gruvbox/blob/master/colors/gruvbox.vim#L88
" Match gutters to background
:highlight SignColumn ctermbg=235
:highlight FoldColumn ctermbg=235
:highlight CursorLineNr ctermbg=235
:highlight LineNr ctermfg=239
" Minimise tab colouring (highlight groups here
" https://github.com/ap/vim-buftabline/blob/master/plugin/buftabline.vim#L32-L35)
:highlight BufTabLineCurrent ctermbg=235 ctermfg=228
:highlight BufTabLineActive ctermbg=235 ctermfg=246
:highlight BufTabLineHidden ctermbg=235 ctermfg=246

" Jumping between files/locations
nmap <leader>i <C-o>
nmap <leader>- <C-o>
nmap <leader>o <C-i>
nmap <leader>b :b#<CR>

" Default file list to tree view
let g:netrw_liststyle = 3

" Search
set ignorecase
set smartcase

" JS Folding (thanks
" https://medium.com/vim-drops/javascript-folding-on-vim-119c70d2e872)
set foldmethod=syntax
" Don't actually want to see the gutter though - foldlines are enough
set foldcolumn=0
let javascript_fold=1
set foldlevelstart=99


"""""""""""""""""""""""""""""""""""
" Plugin settings
"""""""""""""""""""""""""""""""""""
" Use ripgrep for FZF file list
let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --glob "!.git/*"'

" COC configuration
" TextEdit might fail if hidden is not set.
set hidden
" CoC is supposed to default tsx files to typescriptreact, but doesn't for me
let g:coc_filetype_map = {
\ 'tsx': 'typescriptreact',
\ }
" The above doesn't seem to work in later versions. autocmd alternative:
augroup ReactFiletypes
  autocmd!
  autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
  autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
augroup END


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use AG for search
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue Prettier

" Eslint
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'javascriptreact': ['eslint'],
  \   'typescript': ['eslint'],
  \   'typescriptreact': ['eslint'],
  \}

" Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }


""""""""""""""""""""""""""""""""""""
" Key mappings
""""""""""""""""""""""""""""""""""""
" Save and quit
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
" Close files using bbye
nmap <leader><leader>q :Bdelete<CR>
" FZF
nmap <leader>p :FzfPreviewProjectFiles<CR> 
nmap <leader><leader>p :FzfPreview<CR> 
nmap <leader><leader>g :FzfPreviewGitStatus<CR> 
" Fugitive
nmap <leader>g :Git<CR>
nmap <leader>gd :Gdiffsplit<CR>
nmap <leader>gs :Git switch 

" COC
nmap <leader>. <Plug>(coc-definition)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>gr <Plug>(coc-references)
nmap <leader><leader>r <Plug>(coc-references)
" Scroll coc popups
" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Right>"
inoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Left>"

" Switching vsplits 
nmap <leader>' <C-w>l
nmap <leader>; <C-w>h
" Switching "tabs" (really buffers, which I show in tabline)
nmap <C-n> :bn<CR>
nmap <C-z> :bp<CR>
" File explorer
nmap <leader>x :Ex<CR>
" Global search (using  ack.vim)
nmap <leader>a :Ack<Space>
" Open/close quickfix
nmap <leader><leader>c :copen<CR>
nmap <leader><leader><leader>c :cclose<CR>
" Jump to lint issues
nmap <silent> <C-S-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" Clear search highlight
nmap <silent> <Esc> :noh<CR>
" Add mappings for selecting and commenting folds
" Add fold textobject
vnoremap af :<C-U>silent! normal! [zV]z<CR>
" Add operation-pending to select fold
omap af :normal Vaf<CR>
" Add mapping to comment current fold
map <leader>cf Vaf<leader>cs
