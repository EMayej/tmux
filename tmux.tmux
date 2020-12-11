#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

theme_agnoster() {
    # http://www.fileformat.info/info/unicode/char/e0b0/fontsupport.htm

    # \uE0B0
    SYMBOL_RIGHT_ARROW_BOLD=$(printf "\xEE\x82\xB0")

    # \u2764
    SYMBOL_HEART=$(printf "\xE2\x9D\xA4")

    # SYMBOL_RIGHT_ARROW_THIN="\uE0B1"
    # SYMBOL_LEFT_ARROW_BOLD="\uE0B2"
    # SYMBOL_LEFT_ARROW_THIN="\uE0B3"

    tmux set-option -g set-titles on
    tmux -u set-option -g set-titles-string "#S $SYMBOL_HEART #I #W"

    tmux set-option -g status-left-length 32
    tmux -u set-option -g status-left "#{?#{==:#{client_key_table},root},#[bg=green],#[bg=yellow]} #{client_key_table} #{?#{==:#{client_key_table},root},#[fg=green],#[fg=yellow]}#[bg=colour234]$SYMBOL_RIGHT_ARROW_BOLD "

    tmux set-option -g status-style fg=colour231,bg=colour234

    tmux set-option -g window-status-format "#I #W"
    tmux -u set-option -g window-status-current-format "#[fg=colour234,bg=colour31]$SYMBOL_RIGHT_ARROW_BOLD#[fg=colour231,bg=colour31] #I #W #[fg=colour31,bg=colour234,nobold]$SYMBOL_RIGHT_ARROW_BOLD"

    tmux set-option -g window-status-last-style fg=colour31

    tmux set-option -g status-right-length 150
}

pane_control() {
    tmux bind-key -T prefix w switch -T T-Windows

    tmux bind-key -T T-Windows w choose-tree -wZ

    # window
    tmux bind-key -T T-Windows p select-window -t '-1' '\;' switch -T T-Windows
    tmux bind-key -T T-Windows n select-window -t '+1' '\;' switch -T T-Windows
    tmux bind-key -T T-Windows 1 select-window -t :=1 '\;' switch -T T-Windows
    tmux bind-key -T T-Windows 2 select-window -t :=2 '\;' switch -T T-Windows
    tmux bind-key -T T-Windows 3 select-window -t :=3 '\;' switch -T T-Windows
    tmux bind-key -T T-Windows 4 select-window -t :=4 '\;' switch -T T-Windows
    tmux bind-key -T T-Windows 5 select-window -t :=5 '\;' switch -T T-Windows
    tmux bind-key -T T-Windows 6 select-window -t :=6 '\;' switch -T T-Windows
    tmux bind-key -T T-Windows 7 select-window -t :=7 '\;' switch -T T-Windows
    tmux bind-key -T T-Windows 8 select-window -t :=8 '\;' switch -T T-Windows
    tmux bind-key -T T-Windows 9 select-window -t :=9 '\;' switch -T T-Windows

    tmux bind-key -T T-Windows c new-window -c "#{pane_current_path}" -n ""

    tmux bind-key -T T-Windows '<' swap-window -t '-1' '\;' select-window -t '-1' '\;' switch -T T-Windows
    tmux bind-key -T T-Windows '>' swap-window -t '+1' '\;' select-window -t '+1' '\;' switch -T T-Windows

    tmux bind-key -T T-Windows - split-window -v -d -c "#{pane_current_path}"
    tmux bind-key -T T-Windows s split-window -v -d -c "#{pane_current_path}"
    tmux bind-key -T T-Windows S split-window -v -c "#{pane_current_path}"

    tmux bind-key -T T-Windows / split-window -h -d -c "#{pane_current_path}"
    tmux bind-key -T T-Windows v split-window -h -d -c "#{pane_current_path}"
    tmux bind-key -T T-Windows V split-window -h -c "#{pane_current_path}"

    tmux bind-key -T T-Windows r rotate-window -D '\;' switch -T T-Windows
    tmux bind-key -T T-Windows R rotate-window -U '\;' switch -T T-Windows

    # pane
    tmux bind-key -T T-Windows j select-pane -D '\;' switch -T T-Windows
    tmux bind-key -T T-Windows k select-pane -U '\;' switch -T T-Windows
    tmux bind-key -T T-Windows h select-pane -L '\;' switch -T T-Windows
    tmux bind-key -T T-Windows l select-pane -R '\;' switch -T T-Windows

    tmux bind-key -T T-Windows '[' resize-pane -L '\;' switch -T T-Windows
    tmux bind-key -T T-Windows ']' resize-pane -R '\;' switch -T T-Windows
    tmux bind-key -T T-Windows '{' resize-pane -U '\;' switch -T T-Windows
    tmux bind-key -T T-Windows '}' resize-pane -D '\;' switch -T T-Windows
    tmux bind-key -T T-Windows J resize-pane -D 5 '\;' switch -T T-Windows
    tmux bind-key -T T-Windows K resize-pane -U 5 '\;' switch -T T-Windows
    tmux bind-key -T T-Windows H resize-pane -L 5 '\;' switch -T T-Windows
    tmux bind-key -T T-Windows L resize-pane -R 5 '\;' switch -T T-Windows

    tmux bind-key -T T-Windows d kill-pane
    tmux bind-key -T T-Windows D kill-pane -a

    tmux bind-key -T T-Windows m resize-pane -Z
}


main() {
    theme_agnoster

    pane_control
}

main
