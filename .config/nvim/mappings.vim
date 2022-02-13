"Exiting terminal mode with Esc"
tnoremap <Esc> <C-\><C-n>
inoremap <C-d> gD 
map <Tab> :NvimTreeToggle<cr>

" Move to previous/next
map <silent>    <A-Left>  :BufferLineCyclePrev<CR>
map <silent>    <A-Right> :BufferLineCycleNext<CR>
" Re-order to previous/next
map <silent>    <A-<> :BufferLineMovePrev<CR>
map <silent>    <A->> :BufferLineMoveNext<CR>
" Goto buffer in position...
map <silent>    <A-1> :BufferLineGoToBuffer 1<CR>
map <silent>    <A-2> :BufferLineGoToBuffer 2<CR>
map <silent>    <A-3> :BufferLineGoToBuffer 3<CR>
map <silent>    <A-4> :BufferLineGoToBuffer 4<CR>
map <silent>    <A-5> :BufferLineGoToBuffer 5<CR>
map <silent>    <A-6> :BufferLineGoToBuffer 6<CR>
map <silent>    <A-7> :BufferLineGoToBuffer 7<CR>
map <silent>    <A-8> :BufferLineGoToBuffer 8<CR>
map <silent>    <A-9> :BufferLineGoToBuffer 9<CR>
" Close buffer
map <silent>    <A-q> :bdelete<CR>
