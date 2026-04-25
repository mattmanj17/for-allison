# --variable=geometry:showframe `
# --include-in-header=.\page-border.tex `

.\box-wrap.ps1 .\work.txt .\boxed-work.txt
pandoc `
    --standalone `
    --variable=mainfont:"Consolas" `
    --variable=monofont:"Consolas" `
    --variable=papersize:letter `
    --variable=geometry:margin=1.25in `
    --variable=pagestyle:empty `
    --variable=documentclass:extarticle `
    --variable=fontsize:17pt `
    --from=.\plain-reader.lua `
    --to=pdf `
    --pdf-engine=xelatex `
    --output=.\matthewd-to-allisond.pdf `
    .\boxed-work.txt
Remove-Item .\boxed-work.txt