#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set_start_bindings() {
    tmux set-option -g prefix M-m

    tmux set-option -g default-shell /usr/local/bin/fish
    tmux set-option -g default-terminal xterm-256color

    tmux set-option -g base-index 1
    tmux set-option -g pane-base-index 1

    tmux set-option -g -w xterm-keys on
    tmux set-option -g allow-rename on
    tmux set-option -g renumber-windows on
    tmux set-option -g -w automatic-rename on
    tmux set-option -g set-titles on
    tmux set-option -g set-titles-string '#h ❐ #S ● #I #W'
    tmux set-option -g monitor-activity on
    tmux set-option -g visual-activity off

    tmux set-option -g display-panes-time 2000

    tmux bind-key -T prefix '*' set -w synchronize-pane

    tmux bind-key -T prefix Tab last-window
    tmux bind-key -T prefix c new-window -c "#{pane_current_path}" -n ""
    # Break and merge windows and panes
    # ^ pulls a window into a horizontal pane
    # < pulls a window into a vertical pane
    # > breaks it back out into its own window
    tmux bind-key '^' split-window -v '\;' choose-tree -w 'kill-pane; join-pane -vs %%'
    tmux bind-key '<' split-window -h '\;' choose-tree -w 'kill-pane; join-pane -hs %%'
    tmux bind-key '>' break-pane -d
}

set_copy_mode_vi() {
    tmux set-option -w -g mode-keys vi
    tmux bind-key -T prefix Escape copy-mode
    tmux bind-key -T copy-mode-vi v send -X begin-selection
    tmux bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel pbcopy
}

set_theme() {
    tmux set-option -g status-bg black #base02
    tmux set-option -g status-fg yellow #yellow
    tmux set-option -g status-attr default
    tmux set-option -g status-left '#{s/root//:client_key_table}'

    # default window title colors
    tmux set-option -w -g window-status-fg brightblue #base0
    tmux set-option -w -g window-status-bg default
    tmux set-option -w -g window-status-attr dim

    # active window title colors
    tmux set-option -w -g window-status-current-fg brightred #orange
    tmux set-option -w -g window-status-current-bg default
    tmux set-option -w -g window-status-current-attr bright

    # pane border
    tmux set-option -g pane-border-fg black #base02
    tmux set-option -g pane-active-border-fg brightgreen #base01

    # message text
    tmux set-option -g message-bg black #base02
    tmux set-option -g message-fg brightred #orange

    # pane number display
    tmux set-option -g display-panes-active-colour blue #blue
    tmux set-option -g display-panes-colour brightred #orange

    # clock
    tmux set-option -w -g clock-mode-colour green #green

    # bell
    tmux set-option -w -g window-status-bell-style fg=black,bg=red #base02, red
}

main() {
    set_start_bindings
    set_copy_mode_vi
    set_theme
}
main
