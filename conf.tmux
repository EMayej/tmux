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

    tmux set-option -g display-panes-time 2000

    tmux bind-key -T prefix '*' set -w synchronize-pane

    tmux bind-key -T prefix Tab last-window
    tmux bind-key -T prefix c new-window -c "#{pane_current_path}" -n ""
    # Break and merge windows and panes
    # ^ pulls a window into a horizontal pane
    # < pulls a window into a vertical pane
    # > breaks it back out into its own window
    tmux bind-key '^' split-window -v '\;' choose-window 'kill-pane; join-pane -vs %%'
    tmux bind-key '<' split-window -h '\;' choose-window 'kill-pane; join-pane -hs %%'
    tmux bind-key '>' break-pane -d

    tmux bind-key R source-file ~/.tmux.conf '\;' display-message "Config reloaded..."
}

main() {
    set_start_bindings
}
main
