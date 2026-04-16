# 1. Ruta del repo local
$repoPath = "C:\Bre\Programacion\MIS APP\antigravity"

# 2. Archivos específicos a incluir
$files = @(
    (Join-Path $repoPath "Login.aspx"),
    (Join-Path $repoPath "Login.aspx.vb")
)

# 3. Construir contenido para el prompt
$promptContent = ""
foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        $promptContent += "### " + (Split-Path $file -Leaf) + "`n" + $content + "`n`n"
    }
}

$prompt = @"
Analizar los siguientes archivos de un proyecto ASP.NET WebForms.
No generar código nuevo.
Solo producir documentación en texto, explicando:
- Para qué se usa cada archivo dentro del sistema (ejemplo: login es para ingresar al sistema).
- Qué tecnologías utiliza (ASP.NET, VB.NET, Bootstrap, jQuery, etc.).
- Cómo se relaciona con los demás archivos del proyecto.
No detallar el contenido del formulario ni línea por línea, solo interpretar su propósito y las tecnologías involucradas.

$promptContent
"@

# 5. Construir objeto con parámetros
$body = @{
    model  = "granite-code:latest"
    prompt = $prompt
    stream = $false
}

# 6. Convertir a JSON seguro
$jsonBody = $body | ConvertTo-Json -Depth 3

# 7. Llamar a Ollama
$response = Invoke-RestMethod -Uri "http://localhost:11434/api/generate" `
    -Method Post -ContentType "application/json" -Body $jsonBody

# 8. Guardar salida cruda para debug
$response.response | Out-File -FilePath (Join-Path $repoPath "response.txt") -Encoding utf8

# 9. Guardar documentación en README.md
$docFile = Join-Path $repoPath "README.md"
$response.response | Out-File -FilePath $docFile -Encoding utf8
Write-Host "Documentación generada en $docFile"

# 10. Subir al GitHub
Set-Location $repoPath
git add .
git commit -m "Documentación generada automáticamente con Ollama Granite"
git push origin main
