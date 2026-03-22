# Spawn Backends

## Auto-Detection Logic

```
Running inside tmux ($TMUX set)?  → tmux backend
Running in iTerm2 + it2 installed? → iterm2 backend
tmux available (not inside)?       → tmux (external session)
Otherwise                          → in-process (default)
```

## in-process (Default)
- Same Node.js process, no new processes spawned
- Fastest, works everywhere, lowest overhead
- Downside: can't see teammate output in real-time

## tmux
- Each teammate gets its own tmux pane
- See output in real-time; teammates survive leader exit
- Requires: `brew install tmux`

```bash
tmux new-session -s claude   # start session first
# OR force:
export CLAUDE_CODE_SPAWN_BACKEND=tmux
```

Useful commands:
```bash
tmux list-panes              # list panes in current window
tmux select-pane -t 1        # switch to pane
tmux attach -t claude-swarm  # view external swarm session
```

## iterm2 (macOS only)
- Split panes within iTerm2 window, visual side-by-side

Setup:
```bash
uv tool install it2          # install CLI
# Enable in iTerm2 → Settings → General → Magic → Enable Python API
# Restart iTerm2
```

## Force a Backend
```bash
export CLAUDE_CODE_SPAWN_BACKEND=in-process   # fastest, no visibility
export CLAUDE_CODE_SPAWN_BACKEND=tmux         # visible, persistent
unset CLAUDE_CODE_SPAWN_BACKEND               # auto-detect (default)
```

## Troubleshooting

| Issue | Cause | Fix |
|-------|-------|-----|
| "No pane backend available" | Neither tmux nor iTerm2 | `brew install tmux` |
| "it2 CLI not installed" | In iTerm2, missing it2 | `uv tool install it2` |
| Workers not visible | in-process backend | Start inside tmux or iTerm2 |
| Workers dying unexpectedly | Outside tmux, leader exited | Use tmux for persistence |
