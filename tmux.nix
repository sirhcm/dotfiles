{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    extraConfig = ''
      set-option -g default-command "exec $SHELL"
      unbind '"'
      unbind %

      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      set -g status-style 'fg=color1'
      set -g status-left ""

      setw -g window-status-current-style 'fg=color0 bg=color1 bold'
      setw -g window-status-current-format ' #I #W #F '

      setw -g window-status-style 'fg=color1 dim'
      setw -g window-status-format ' #I #[fg=color7]#W #[fg=color1]#F '

      bind -r -T prefix C-k resize-pane -U 5
      bind -r -T prefix C-j resize-pane -D 5
      bind -r -T prefix C-h resize-pane -L 5
      bind -r -T prefix C-l resize-pane -R 5
      bind H split-window -h
      bind J split-window -v
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };
}
