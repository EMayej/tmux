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

pane_root_bindings() {
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
}

pane_select_bindings() {
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
}

pane_move_bindings() {
    tmux bind-key -T T-Window-Manipulate J resize-pane -D 5 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate K resize-pane -U 5 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate H resize-pane -L 5 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate L resize-pane -R 5 '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate r rotate-window -D '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate R rotate-window -U '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate '<' swap-window -t '-1' '\;' select-window -t '-1' '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate '>' swap-window -t '+1' '\;' select-window -t '+1' '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate d kill-pane '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate D kill-pane -a '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate c new-window -c "#{pane_current_path}" -n "" '\;' switch -T T-Window-Manipulate
}

pane_split_bindings() {
    tmux bind-key -T T-Window-Manipulate s split-window -h -d -c "#{pane_current_path}" '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate S split-window -h -c "#{pane_current_path}" '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate v split-window -v -d -c "#{pane_current_path}" '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate V split-window -v -c "#{pane_current_path}" '\;' switch -T T-Window-Manipulate
}

pane_resize_bindings() {
    tmux bind-key -T T-Window-Manipulate '[' resize-pane -L '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate ']' resize-pane -R '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate '{' resize-pane -U '\;' switch -T T-Window-Manipulate
    tmux bind-key -T T-Window-Manipulate '}' resize-pane -D '\;' switch -T T-Window-Manipulate
}

main() {
    theme_agnoster

    pane_root_bindings
    pane_select_bindings
    pane_move_bindings
    pane_split_bindings
    pane_resize_bindings
}
main
