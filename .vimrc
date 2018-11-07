execute pathogen#infect()

let mapleader = ','
:colorscheme gruvbox

nmap <C-z> :so ~/.vimrc<CR>

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

" Panes
nmap <leader>v :vs<CR>
nmap <leader>' <C-w>l
nmap <leader>; <C-w>h

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
