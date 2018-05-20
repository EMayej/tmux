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

set_layout_bindings() {
    tmux bind-key -T prefix l switch -T LAYOUT
    tmux bind-key -T prefix / split-window -h -c "#{pane_current_path}"
    tmux bind-key -T prefix - split-window -c "#{pane_current_path}"

    # select
    tmux bind-key -T LAYOUT j select-pane -D '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT k select-pane -U '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT h select-pane -L '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT l select-pane -R '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT C-h previous-window '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT C-l next-window '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT 0 select-window -t :=0 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT 1 select-window -t :=1 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT 2 select-window -t :=2 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT 3 select-window -t :=3 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT 4 select-window -t :=4 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT 5 select-window -t :=5 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT 6 select-window -t :=6 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT 7 select-window -t :=7 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT 8 select-window -t :=8 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT 9 select-window -t :=9 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT w select-pane -t :.+ '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT o switch -n '\;' switch -T LAYOUT

    # move
    tmux bind-key -T LAYOUT J resize-pane -D 5 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT K resize-pane -U 5 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT H resize-pane -L 5 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT L resize-pane -R 5 '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT r rotate-window -D '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT R rotate-window -U '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT '<' swap-window -t '-1' '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT '>' swap-window -t '+1' '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT d kill-pane '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT D kill-pane -a '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT c new-window -c "#{pane_current_path}" -n "" '\;' switch -T LAYOUT

    # split
    tmux bind-key -T LAYOUT s split-window -h -d -c "#{pane_current_path}" '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT S split-window -h -c "#{pane_current_path}" '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT v split-window -v -d -c "#{pane_current_path}" '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT V split-window -v -c "#{pane_current_path}" '\;' switch -T LAYOUT

    # resize
    tmux bind-key -T LAYOUT '[' resize-pane -L '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT ']' resize-pane -R '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT '{' resize-pane -U '\;' switch -T LAYOUT
    tmux bind-key -T LAYOUT '}' resize-pane -D '\;' switch -T LAYOUT
}

main() {
    set_start_bindings
    set_layout_bindings
}
main
