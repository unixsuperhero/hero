#!/bin/bash

tmux 

# sessions
#
#  attach-session (attach) [-dr] [-c working-directory] [-t target-session]
#  choose-session [-t target-window] [-F format] [template]
#  has-session (has) [-t target-session]
#  kill-session [-a] [-t target-session]
#  list-sessions (ls) [-F format]
#  lock-session (locks) [-t target-session]
#  new-session (new) [-AdDP] [-c start-directory] [-F format] [-n window-name] [-s session-name] [-t target-session] [-x width] [-y height] [command]
#  rename-session (rename) [-t target-session] new-name

# windows
#
#  choose-window [-t target-window][-F format] [template]
#  find-window (findw) [-CNT] [-F format] [-t target-window] match-string
#  kill-window (killw) [-a] [-t target-window]
#  last-window (last) [-t target-session]
#  link-window (linkw) [-dk] [-s src-window] [-t dst-window]
#  list-windows (lsw) [-a] [-F format] [-t target-session]
#  move-window (movew) [-dkr] [-s src-window] [-t dst-window]
#  new-window (neww) [-adkP] [-c start-directory] [-F format] [-n window-name] [-t target-window] [command]
#  next-window (next) [-a] [-t target-session]
#  previous-window (prev) [-a] [-t target-session]
#  rename-window (renamew) [-t target-window] new-name
#  respawn-window (respawnw) [-k] [-t target-window] [command]
#  rotate-window (rotatew) [-DU] [-t target-window]
#  select-window (selectw) [-lnpT] [-t target-window]
#  set-window-option (setw) [-agoqu] [-t target-window] option [value]
#  show-window-options (showw) [-gv] [-t target-window] [option]
#  split-window (splitw) [-dhvP] [-c start-directory] [-F format] [-p percentage|-l size] [-t target-pane] [command]
#  swap-window (swapw) [-d] [-s src-window] [-t dst-window]
#  unlink-window (unlinkw) [-k] [-t target-window]

# panes
#
#  break-pane (breakp) [-dP] [-F format] [-t target-pane]
#  capture-pane (capturep) [-aCeJpPq] [-b buffer-index] [-E end-line] [-S start-line][-t target-pane]
#  display-panes (displayp) [-t target-client]
#  join-pane (joinp) [-bdhv] [-p percentage|-l size] [-s src-pane] [-t dst-pane]
#  kill-pane (killp) [-a] [-t target-pane]
#  last-pane (lastp) [-t target-window]
#  list-panes (lsp) [-as] [-F format] [-t target-window]
#  move-pane (movep) [-bdhv] [-p percentage|-l size] [-s src-pane] [-t dst-pane]
#  pipe-pane (pipep) [-o] [-t target-pane] [command]
#  resize-pane (resizep) [-DLRUZ] [-x width] [-y height] [-t target-pane] [adjustment]
#  respawn-pane (respawnp) [-k] [-t target-pane] [command]
#  select-pane (selectp) [-lDLRU] [-t target-pane]
#  swap-pane (swapp) [-dDU] [-s src-pane] [-t dst-pane]

# do not know
#
## bind-key (bind) [-cnr] [-t key-table] key command [arguments]
## choose-buffer [-t target-window] [-F format] [template]
## choose-client [-t target-window] [-F format] [template]
## choose-list [-l items] [-t target-window][template]
## choose-tree [-suw] [-b session-template] [-c window template] [-S format] [-W format] [-t target-window]
## clear-history (clearhist) [-t target-pane]
## clock-mode [-t target-pane]
## command-prompt [-I inputs] [-p prompts] [-t target-client] [template]
## confirm-before (confirm) [-p prompt] [-t target-client] command
## copy-mode [-u] [-t target-pane]
## delete-buffer (deleteb) [-b buffer-index]
## detach-client (detach) [-P] [-a] [-s target-session] [-t target-client]
## display-message (display) [-p] [-c target-client] [-F format] [-t target-pane] [message]
## if-shell (if) [-b] [-t target-pane] shell-command command [command]
## kill-server 
## list-buffers (lsb) [-F format]
## list-clients (lsc) [-F format] [-t target-session]
## list-commands (lscm) 
## list-keys (lsk) [-t key-table]
## load-buffer (loadb) [-b buffer-index] path
## lock-client (lockc) [-t target-client]
## lock-server (lock) 
## next-layout (nextl) [-t target-window]
## paste-buffer (pasteb) [-dpr] [-s separator] [-b buffer-index] [-t target-pane]
## previous-layout (prevl) [-t target-window]
## refresh-client (refresh) [-S] [-C size] [-t target-client]
## run-shell (run) [-b] [-t target-pane] shell-command
## save-buffer (saveb) [-a] [-b buffer-index] path
## select-layout (selectl) [-np] [-t target-window] [layout-name]
## send-keys (send) [-lR] [-t target-pane] key ...
## send-prefix [-2] [-t target-pane]
## server-info (info) 
## set-buffer (setb) [-b buffer-index] data
## set-environment (setenv) [-gru] [-t target-session] name [value]
## set-option (set) [-agosquw] [-t target-session|target-window] option [value]
## show-buffer (showb) [-b buffer-index]
## show-environment (showenv) [-g] [-t target-session] [name]
## show-messages (showmsgs) [-IJT] [-t target-client]
## show-options (show) [-gqsvw] [-t target-session|target-window] [option]
## source-file (source) path
## start-server (start) 
## suspend-client (suspendc) [-t target-client]
## switch-client (switchc) [-lnpr] [-c target-client] [-t target-session]
## unbind-key (unbind) [-acn] [-t key-table] key
## wait-for (wait) [-L|-S|-U] channel
