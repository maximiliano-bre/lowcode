# 1. Ruta del repo local
$repoPath = "C:\Bre\Programacion\MIS APP\antigravity"

# 2. Extensiones a incluir
$extensions = "*.aspx","*.cs","*.js","*.css","*.config"

# 3. Construir contenido para el prompt
$promptContent = ""
foreach ($ext in $extensions) {
    $files = Get-ChildItem -Path $repoPath -Include $ext -Recurse
    foreach ($file in $files) {
        $content = Get-Content $file.FullName -Raw
        $promptContent += "### " + $file.Name + "`n" + $content + "`n`n"
    }
}

# 4. Prompt final para documentación
$prompt = @"
Analizar los siguientes archivos de un proyecto ASP.NET WebForms.
No generar código nuevo.
Solo producir documentación en texto, explicando:
- Qué hace cada archivo.
- Cómo se relaciona con los demás.
- El propósito general del sitio.
El resultado debe ser un README.md con secciones claras.

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

# 8. Guardar documentación en README.md
$docFile = Join-Path $repoPath "README.md"
$response.response | Out-File -FilePath $docFile -Encoding utf8
Write-Host "Documentación generada en $docFile"

# 9. Subir al GitHub
Set-Location $repoPath
git add .
git commit -m "Documentación generada automáticamente con Ollama Granite"
git push origin main
