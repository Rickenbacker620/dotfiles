#
# Microsoft.PowerShell_profile.ps1 (PowerShell 7+)
#

# Remove built-in aliases that shadow the functions below
Remove-Item Alias:ls -Force -ErrorAction SilentlyContinue
Remove-Item Alias:cat -Force -ErrorAction SilentlyContinue

# File listing (eza)
function ls { eza --icons=auto @args }
function ll { eza --time-style="+%y-%m-%d %H:%M" --icons=auto -hla @args }
function tree { eza --tree --git-ignore @args }

# Cat with syntax highlighting (bat)
function cat { bat @args }
function less { bat @args }

# Search (ripgrep)
function grep { rg @args }

# Disk usage
function du { dust @args }
function df { duf @args }

# yazi cd-on-exit wrapper
function f {
	$tmp = [System.IO.Path]::GetTempFileName()
	yazi @args --cwd-file="$tmp"
	$cwd = Get-Content -Raw -Path $tmp -ErrorAction SilentlyContinue
	if ($cwd) {
		$cwd = $cwd.Trim()
		if ($cwd -and $cwd -ne (Get-Location).Path -and (Test-Path -LiteralPath $cwd)) {
			Set-Location -LiteralPath $cwd
		}
	}
	Remove-Item -Force -Path $tmp -ErrorAction SilentlyContinue
}

starship init powershell | Out-String | Invoke-Expression
