{ config, pkgs, inputs, ... }:

let
  handarbeit = pkgs.vimUtils.buildVimPlugin {
    name = "handarbeit";
    src = inputs.handarbeit-vim;
  };
in
{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      handarbeit
      polyglot
      sleuth
      fugitive
      gitgutter
      lightline-vim
      fzf-vim
      nerdcommenter
      vim-gutentags
      ale
    ];
    settings = {
      ignorecase = true;
      smartcase = true;
      expandtab = true;
      number = true;
      shiftwidth = 2;
      tabstop = 2;
    };
    extraConfig = ''
      set nofixeol
      colorscheme handarbeit
      let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left':  [ ['mode', 'paste'],
      \              ['gitbranch', 'readonly', 'filename', 'modified'] ],
      \   'right': [ ['lineinfo'], ['percent'], ['filetype'], ['search'] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \}
      set autoindent
      set smartindent
      set smarttab
      set nowrap
      set list
      set listchars=trail:~,extends:>,precedes:<
      set scrolloff=8
      set signcolumn=auto
      set noshowmode
      set showcmd
      set conceallevel=1
      set noerrorbells visualbell t_vb=
      set incsearch
      set hlsearch
      let mapleader=" "
      let maplocalleader=" "
      nnoremap <SPACE> <Nop>
      nnoremap <CR> :noh<CR><CR>:<backspace>
      nnoremap <leader>s :<C-u>Files<CR>
      nnoremap <leader>d :<C-u>Tags<CR>
      nnoremap <leader>D :<C-u>BTags<CR>
      let g:gutentags_generate_on_write = 1
      let g:gutentags_generate_on_missing = 1
      let g:gutentags_generate_on_new = 1
      let g:gutentags_file_List_command = "git ls-files"

      let g:ale_linters_explicit = 1
      let g:ale_linters = { 'python': ['ruff'] }
    '';
  };
}
