oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\mt.omp.json" | Invoke-Expression

$RG_PREFIX = "rg --files | rg"
$env:FZF_DEFAULT_COMMAND = "rg --files"
$env:FZF_DEFAULT_OPTS = "
    --bind 'change:reload:$RG_PREFIX {q}'
    --ansi
    --disabled
    --preview-window 'up,60%'
    --layout=reverse
    --preview 'bat --style=numbers --color=always {}'
"

Invoke-Expression -Command $(gh completion -s powershell | Out-String)
Invoke-Expression -Command $(rustup completions powershell | Out-String)
# not currently supported
# Invoke-Expression -Command $(rustup completions powershell cargo | Out-String)
