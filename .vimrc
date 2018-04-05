execute pathogen#infect()

let mapleader = ','
:colorscheme gruvbox

nmap <C-z> :so ~/.vimrc<CR>

" File stuff
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

" Jumping between files/locations
nmap <leader>o <C-o>
nmap <leader>i <C-i>
nmap <leader>b :b#<CR>

set background=dark
" Line numbers
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Ignore git ignored files when fuzzy finding
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
nmap <leader>p <C-p>

" Panes
nmap <leader>v :vs<CR>
nmap <leader>' <C-w>l
nmap <leader>; <C-w>h

" YCM mappings
nmap <leader>. :YcmCompleter GoToDefinition<CR>

" ALE
let g:ale_sign_error = '👻'
let g:ale_sign_warning = '🔥'
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
nmap <leader>f :ALEFix<CR>

" Clear search highlight with escape
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Git
nmap <leader>gb :Gblame<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gdd :Gdiffoff<CR>

" Searching
let g:ackprg = "ag --vimgrep"
