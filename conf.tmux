#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set_start_bindings() {
    tmux set-option -g prefix "\`"
    tmux bind-key -T prefix "\`" send-prefix

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

my_settings() {
    tmux set-option -g allow-rename off
    tmux set-option -g default-terminal "xterm-256color"
}

main() {
    set_start_bindings
    set_copy_mode_vi
    my_settings
}
main
