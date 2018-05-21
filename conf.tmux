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
}

set_layout_bindings() {
    tmux bind-key -T prefix w switch -T T-Windows

    tmux bind-key -T T-Windows . switch -T T-Window-Manipulate # Window Manipulation Transient State
    tmux bind-key -T T-Windows / split-window -h -c "#{pane_current_path}"
    tmux bind-key -T T-Windows - split-window -c "#{pane_current_path}"
    tmux bind-key -T T-Windows j select-pane -D
    tmux bind-key -T T-Windows k select-pane -U
    tmux bind-key -T T-Windows h select-pane -L
    tmux bind-key -T T-Windows l select-pane -R
    tmux bind-key -T T-Windows m resize-pane -Z
    tmux bind-key -T T-Windows w choose-tree -wZ

    # select
    tmux bind-key -T T-Window-Manipulate j select-pane -D '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate k select-pane -U '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate h select-pane -L '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate l select-pane -R '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate C-h previous-window '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate C-l next-window '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate 0 select-window -t :=0 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate 1 select-window -t :=1 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate 2 select-window -t :=2 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate 3 select-window -t :=3 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate 4 select-window -t :=4 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate 5 select-window -t :=5 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate 6 select-window -t :=6 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate 7 select-window -t :=7 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate 8 select-window -t :=8 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate 9 select-window -t :=9 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate w select-pane -t :.+ '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate o switch -n '\;' switch -T T-Window-Manipulate

    # move
    tmux bind-key -T T-Window-Manipulate J resize-pane -D 5 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate K resize-pane -U 5 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate H resize-pane -L 5 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate L resize-pane -R 5 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate r rotate-window -D '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate R rotate-window -U '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate '<' swap-window -t '-1' '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate '>' swap-window -t '+1' '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate d kill-pane '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate D kill-pane -a '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate c new-window -c "#{pane_current_path}" -n "" '\;' switch -T T-Window-Manipulate

    # split
    tmux bind-key -T T-Window-Manipulate s split-window -h -d -c "#{pane_current_path}" '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate S split-window -h -c "#{pane_current_path}" '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate v split-window -v -d -c "#{pane_current_path}" '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate V split-window -v -c "#{pane_current_path}" '\;' switch -T T-Window-Manipulate

    # resize
    tmux bind-key -T T-Window-Manipulate '[' resize-pane -L '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate ']' resize-pane -R '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate '{' resize-pane -U '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate '}' resize-pane -D '\;' switch -T T-Window-Manipulate
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
    set_layout_bindings
    set_copy_mode_vi
    set_theme
}
main
