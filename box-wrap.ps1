param(
    [Parameter(Mandatory = $true)]
    [string]$Path,

    [string]$OutputPath
)

$box_width  = 40
$box_height = 25

$inner_width  = $box_width - 2
$inner_height = $box_height - 2

$line_width = $inner_width - 2

if (!(Test-Path $Path)) {
    throw "File not found: $Path"
}

$lines = [System.IO.File]::ReadAllLines(
    (Resolve-Path $Path),
    [System.Text.Encoding]::UTF8
)

if ($lines.Count -gt $inner_height) {
    throw "File has too many lines"
}

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]

    if ($line.Contains("`t")) {
        throw "Line contains a tab"
    }

    if ($line.Length -gt $line_width) {
        throw "Line $($i + 1) is too long"
    }
}

$out = New-Object System.Collections.Generic.List[string]

$out.Add("┌" + ("─" * $inner_width) + "┐")

foreach ($line in $lines) {
    $out.Add("│ " + $line.PadRight($line_width) + " │")
}

for ($i = $lines.Count; $i -lt $inner_height; $i++) {
    $out.Add("│" + (" " * $inner_width) + "│")
}

$out.Add("└" + ("─" * $inner_width) + "┘")

if ($OutputPath) {
    [System.IO.File]::WriteAllLines(
        $OutputPath,
        $out,
        [System.Text.UTF8Encoding]::new($false)
    )
} else {
    $out
}