# Workstation inventory troubleshooting

Use fixed read-only checks first. Never run AWS login or inspect credential files
to troubleshoot this lab.

## Docker client works but server does not

The CLI can be installed while Docker Desktop is stopped, its Linux engine is not
ready, or the current session cannot access it. In your normal PowerShell terminal,
run `docker version` and distinguish Client from Server. Inspect Docker Desktop's
visible status. Do not reset Docker or delete volumes to solve a version check.

Starting Docker Desktop is a later explicit workstation step; the inventory helper
does not start it. Do not change a remote Docker context just to make the check pass.
The eventual lab must use the local Linux engine, not a remote/cloud engine.

## WSL reports access denied

Retry `wsl --status` and `wsl --list --verbose` in the normal user terminal. A
restricted agent session can fail even when WSL itself works. Record the context
and error. Do not reinstall WSL or change permissions without identifying the cause.

## Tool not found / old version

Record installed versus proposed version from the tool catalog. Installation and
checksum verification belong to the next milestone after review. Do not execute
downloaded install scripts or replace system-wide tools automatically.

## Report handling

The inventory JSON includes versions, command output and available disk space, not
an environment-variable dump. Command errors can still contain machine-specific
information. Keep raw output in `.lab/reports/` and sanitize summaries before sharing.

## Exit criteria

Document what is known, which checks were blocked by session restrictions, and what
the learner observed in their own terminal. No successful Docker workload or isolation
claim follows merely from having the Docker executable installed.
