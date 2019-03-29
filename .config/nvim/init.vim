" Author: Enan Ajmain
" Email : 3nan.ajmain@gmail.com
" Github: https://github.com/enanajmain

" -- Vim Plug ------------------------------------------------------------------

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

call plug#end()

" -- General -------------------------------------------------------------------

" visual perks
set colorcolumn=81
set conceallevel=0
let &fillchars="vert:│"
set nocursorline
set nolazyredraw
set nomodeline
set nonumber
set norelativenumber
set noruler
set showmode
set signcolumn=yes

" new split position
set nosplitbelow
set nosplitright

" dictionary and spelling
set dictionary=/usr/share/dict/words
set spelllang=en_us

" searching
set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan
if executable('ag')
	let &grepprg="ag --nogroup --nocolor --hidden --ignore .git"
endif

" wildmenu settings
set wildmenu
set wildignorecase
let &wildmode="full"
set wildignore=*.o,*.obj,*~
set wildignore+=*.swp,*.tmp
set wildignore+=*.mp3,*.mp4,*mkv
set wildignore+=*.bmp,*.gif,*ico,*.jpg,*.png
set wildignore+=*.pdf,*.doc,*.docx,*.ppt,*.pptx
set wildignore+=*.rar,*.zip,*.tar,*.tar.gz,*.tar.xz

" show useful visual icons
set list
let &listchars="tab:┆\ ,trail:▫,nbsp:_,extends:»,precedes:«"

" wrap lines visually
set nowrap
set breakindent
set linebreak
let &showbreak = "↪ "
set breakindentopt=shift:2

" keymap timeout settings
set notimeout
set ttimeout
set ttimeoutlen=10

" miscellaneous options
let &inccommand="nosplit"
set backspace=indent,eol,start
set cinoptions=g0,l1,i0,t0
set cpoptions-=aA
set shortmess=filmnxrtToO
set synmaxcol=200
set updatetime=250
set virtualedit=block

" backup and persistent undo
set nobackup
set noswapfile
set backupdir=~/.local/share/nvim/backup//
set directory=~/.local/share/nvim/swap//
if has('persistent_undo')
	set undofile
	set undodir=~/.local/share/nvim/undo//
endif

" colorscheme
syntax on
set termguicolors
colorscheme fault
let g:lisp_rainbow = 1

" -- Clipboard -----------------------------------------------------------------

let g:clipboard = {
			\   'name': 'xclip-xfce4-clipman',
			\   'copy': {
			\      '+': 'xclip -selection clipboard',
			\      '*': 'xclip -selection clipboard',
			\    },
			\   'paste': {
			\      '+': 'xclip -selection clipboard -o',
			\      '*': 'xclip -selection clipboard -o',
			\   },
			\   'cache_enabled': 1,
			\ }

" -- Tab settings --------------------------------------------------------------

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set shiftround
set noexpandtab

command! -nargs=1 Spaces execute "setlocal tabstop=" . <args> . " shiftwidth="
			\ . <args> . " softtabstop=" . <args> . " expandtab" |
			\ echo "tabstop = shiftwidth = softtabstop = " . &tabstop
			\ . " -> ".(&expandtab ? "spaces" : "tabs")
command! -nargs=1 Tabs execute "setlocal tabstop=" . <args> . " shiftwidth="
			\ . <args> . " softtabstop=" . <args> . " noexpandtab" |
			\ echo "tabstop = shiftwidth = softtabstop = " . &tabstop
			\ . " -> ".(&expandtab ? "spaces" : "tabs")

" -- Key Mapping ---------------------------------------------------------------

" map leader
let mapleader = "\<Space>"

" reload vimrc
nnoremap <silent> <Leader>r :so $MYVIMRC<CR>

" Uppercase word mapping
inoremap <C-u> <Esc>m0gUiw`0a

" don't move cursor while joining lines
nnoremap J m0J`0

" don't move cursor while changing case
nnoremap gUiw m0gUiw`0
nnoremap guiw m0guiw`0

" consistent movement
noremap gh _
noremap gl g_

" don't move cursor when searching with * or #
nnoremap <silent> * :let _w = winsaveview()<CR>
			\:normal! *<CR>
			\:call winrestview(_w)<CR>
			\:unlet _w<CR>
nnoremap <silent> # :let _w = winsaveview()<CR>
			\:normal! #<CR>
			\:call winrestview(_w)<CR>
			\:unlet _w<CR>

" use CTRL-G u
inoremap <C-h> <C-g>u<C-h>
inoremap <CR> <C-]><C-g>u<CR>

" sensible yank till last character
nnoremap Y y$

" undo with <S-u>
nnoremap U <C-r>

" command mode history search
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" useful leader mappings
nnoremap <Leader>; :
xnoremap <Leader>; :
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>e :e **/
nnoremap <Leader>f :grep<Space>
nnoremap <Leader>h :nohlsearch<CR>
nnoremap <Leader>m :make<CR>
nnoremap <Leader>s :%s/\v
xnoremap <Leader>s :s/\%V\v

" Show name of syntax element below cursor
command! SynName  echo synIDattr(synID(line("."), col("."), 1), "name")
nnoremap <F12> :SynName<CR>

" strip trailing whitespace
nnoremap <silent> gs :StripTrailingWhiteSpace<CR>
command! -nargs=0 StripTrailingWhiteSpace
			\ let _w=winsaveview() <Bar>
			\ let _s=@/ |
			\ %s/\s\+$//e |
			\ let @/=_s|
			\ unlet _s |
			\ call winrestview(_w) |
			\ unlet _w |
			\ noh

" don't move cursor when searching with * or #
nnoremap <silent> * :let _w = winsaveview()<CR>
			\:normal! *<CR>
			\:call winrestview(_w)<CR>
			\:unlet _w<CR>
nnoremap <silent> # :let _w = winsaveview()<CR>
			\:normal! #<CR>
			\:call winrestview(_w)<CR>
			\:unlet _w<CR>

" use n and N to always go forward and backward
nnoremap <expr> n (v:searchforward ? 'n' : 'N')
nnoremap <expr> N (v:searchforward ? 'N' : 'n')

" better window management
nnoremap <Leader>w <C-w>
nnoremap <Leader>wq ZZ
nnoremap <Leader>wt :tab split<CR>
nnoremap <Leader>wa :b#<CR>
nnoremap <Leader>wb <C-w>s
nnoremap <Leader>ws <Nop>

" switch tabpages
nnoremap <Leader>] gt
nnoremap <Leader>[ gT

" handy bracket mappings
let s:pairs = { 'a' : '', 'b' : 'b', 'l' : 'l', 'q' : 'c', 't' : 't' }
for [s:key, s:value] in items(s:pairs)
	execute 'nnoremap <silent> [' . s:key . ' :' . s:value . 'prev<CR>'
	execute 'nnoremap <silent> ]' . s:key . ' :' . s:value . 'next<CR>'
	execute 'nnoremap <silent> [' . toupper(s:key) . ' :' . s:value . 'first<CR>'
	execute 'nnoremap <silent> ]' . toupper(s:key) . ' :' . s:value . 'last<CR>'
endfor

" toggle
nnoremap <silent> <Leader>th :set hlsearch!<Bar>set hlsearch?<CR>
nnoremap <silent> <Leader>te :set expandtab!<Bar>set expandtab?<CR>
nnoremap <silent> <Leader>tp :set paste!<Bar>set paste?<CR>
nnoremap <silent> <Leader>ts :setlocal spell!<Bar>setlocal spell?<CR>
nnoremap <silent> <Leader>tw :set wrap!<Bar>set wrap?<CR>
nnoremap <silent> <Leader>tl :set nu!<Bar>set rnu!<Cr>
nnoremap <silent> <Leader>tm :let &mouse=(&mouse==#""?"a":"")<Bar>
			\ echo "mouse ".(&mouse==#""?"off":"on")<CR>

" Navigate seamlessly between vim and tmux
if exists('$TMUX')
	function! TmuxOrSplitSwitch(wincmd, tmuxdir) abort
		let previous_winnr = winnr()
		silent! execute "wincmd " . a:wincmd
		if previous_winnr == winnr()
			call system("tmux list-panes -F '#F' | grep -q Z
						\|| tmux select-pane -" . a:tmuxdir)
		endif
	endfunction

	let previous_title = substitute(system("tmux display-message -p
				\ '#{pane_title}'"), '\n', '', '')
	let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
	let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

	nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<CR>
	nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<CR>
	nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<CR>
	nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<CR>
	tnoremap <silent> <C-h> <C-\><C-n>:call TmuxOrSplitSwitch('h', 'L')<CR>
	tnoremap <silent> <C-j> <C-\><C-n>:call TmuxOrSplitSwitch('j', 'D')<CR>
	tnoremap <silent> <C-k> <C-\><C-n>:call TmuxOrSplitSwitch('k', 'U')<CR>
	tnoremap <silent> <C-l> <C-\><C-n>:call TmuxOrSplitSwitch('l', 'R')<CR>
else
	nnoremap <C-h> <C-w>h
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-l> <C-w>l
	tnoremap <C-h> <C-\><C-n><C-w>h
	tnoremap <C-j> <C-\><C-n><C-w>j
	tnoremap <C-k> <C-\><C-n><C-w>k
	tnoremap <C-l> <C-\><C-n><C-w>l
endif
tnoremap <Esc> <C-\><C-n>

" -- Text Objects --------------------------------------------------------------

" simple text-objects
for s:char in [ '_', '.', ':', ',', ';', '<Bar>', '/', '<Bslash>', '*', '+', '%', '`' ]
	execute 'xnoremap i' . s:char . ' :<C-u>normal! T' . s:char . 'vt' . s:char . '<CR>'
	execute 'onoremap i' . s:char . ' :normal vi' . s:char . '<CR>'
	execute 'xnoremap a' . s:char . ' :<C-u>normal! F' . s:char . 'vf' . s:char . '<CR>'
	execute 'onoremap a' . s:char . ' :normal va' . s:char . '<CR>'
endfor

" line text-objects
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o0
onoremap al :normal val<CR>

" buffer text-objects
xnoremap aa GoggV
onoremap aa :normal vaa<CR>

" -- Functions -----------------------------------------------------------------

" use spaces for alignment
function! RetabAlignment() abort
	let vcol = virtcol('.')
	let t = &et
	set et
	.retab
	let &et = t
	unlet t
	normal! ==
	execute 'normal! ' . (vcol) . '|'
	unlet vcol
endfunction
nnoremap <Leader>z :<C-u>call RetabAlignment()<CR>
inoremap <C-z> <C-o>:<C-u>call RetabAlignment()<CR>

" switch windows effortlessly
function! SwitchWindow(count) abort
	let l:current_buf = winbufnr(0)
	exe "buffer" . winbufnr(a:count)
	exe a:count . "wincmd w"
	exe "buffer" . l:current_buf
endfunction
nnoremap <Leader>wx :<C-u>call SwitchWindow(v:count1)<CR>

" redirect the output of a Vim or external command into a scratch buffer
function! Redir(cmd) abort
	if a:cmd =~ '^!'
		execute "let output = system('" . substitute(a:cmd, '^!', '', '') . "')"
	else
		redir => output
		execute a:cmd
		redir END
	endif
	tabnew
	setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
	call setline(1, split(output, "\n"))
	put! = a:cmd
	put = '----'
endfunction
command! -nargs=1 Redir silent call Redir(<f-args>)

" create a temporary buffer with the output of the command `tree`
function! ViewTree() abort
	vertical topleft 30new
	setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
	0read !tree
	goto 1
endfunction
nnoremap <Leader>n :call ViewTree()<CR>

" copy yanked text to tmux pane
function! Send_to_tmux(count) abort
	let _count = (a:count == 0) ? 2 : a:count
	let text = @z
	let text = substitute(text, ';', '\\;', 'g')
	let text = substitute(text, '"', '\\"', 'g')
	let text = substitute(text, '\n', '" Enter "', 'g')
	let text = substitute(text, '!', '\\!', 'g')
	let text = substitute(text, '%', '\\%', 'g')
	let text = substitute(text, '#', '\\#', 'g')
	silent execute "!tmux send-keys -t " . _count . " -- \"" . text . "\""
	silent execute "!tmux send-keys -t " . _count . "Enter"
	unlet _count
	unlet text
endfunction
nnoremap <expr> <Leader>p '"zyip:call Send_to_tmux('.v:count.')<CR>'
xnoremap <expr> <Leader>p '"zy:call Send_to_tmux('.v:count.')<CR>'

" use * and # over visual selection
function! s:VSetSearch(cmdtype)
	let t = @s
	norm! gv"sy
	let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
	let _w = winsaveview()
	let @s = t
	call winrestview(_w)
	unlet _w
	unlet t
endfunction
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>

" -- Autocommand ---------------------------------------------------------------

augroup custom_term
	autocmd!
	autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
	autocmd BufEnter term://* startinsert
augroup END

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost [^l]* nested cwindow
	autocmd QuickFixCmdPost    l* nested lwindow
augroup END

" -- Statusline ----------------------------------------------------------------

set laststatus=2
set statusline=%1*\ %{winnr()}
			\\ %2*\ %{&fileformat==#'unix'?'U':&fileformat==#'dos'?'D':'N'}
			\:%{&readonly\|\|!&modifiable?&modified?'%*':'%%':&modified?'**':'--'}
			\\ %0*\ %<%{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ Name]'}
			\%=
			\\ %2*\ %{&filetype!=#''?&filetype:'none'}
			\\ %1*\ %l:%4(%v\ %)

hi User1 guibg=#98c379 guifg=#282c34
hi User2 guibg=#c678dd guifg=#282c34

" -- Tabline -------------------------------------------------------------------

function! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		let tabnr = i + 1
		let winnr = tabpagewinnr(tabnr)
		let buflist = tabpagebuflist(tabnr)
		let bufnr = buflist[winnr - 1]
		let bufname = fnamemodify(bufname(bufnr), ':t')
		let s .= '%' . tabnr . 'T'
		let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
		let s .= ' ' . tabnr
		let s .= empty(bufname) ? ' [No Name] ' : ' ' . bufname . ' '
	endfor
	let s .= '%#TabLineFill#'
	return s
endfunction
set showtabline=1
set tabline=%!MyTabLine()

" -- Netrw ---------------------------------------------------------------------

let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_browse_split=0
let g:netrw_cursor=0
let g:netrw_hide = 1
let g:netrw_list_hide = '^\./$,^\../$,^\.git/$'
let g:netrw_liststyle=0
let g:netrw_sort_by='name'
let g:netrw_sort_direction='normal'
let g:netrw_winsize=25

" -- Fugitive ------------------------------------------------------------------

nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit<Space>
nnoremap <Leader>gd :Gdiff<Space>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>
