# Leer prompt
$prompt = Get-Content ".\prompts\web.txt" -Raw

# Normalizar y escapar
$promptEscaped = $prompt.Replace('"','\"').Replace("`r","").Replace("`n","\n")

# Construir JSON
$jsonBody = @"
{
  "model": "granite-code:latest",
  "prompt": "$promptEscaped",
  "stream": false
}
"@

# Llamar a Ollama
$response = Invoke-RestMethod -Uri "http://localhost:11434/api/generate" -Method Post -ContentType "application/json" -Body $jsonBody

# Guardar respuesta completa para debug
$response.response | Out-File -FilePath "response.txt" -Encoding utf8

# Normalizar la respuesta (eliminar \r si quedara)
$raw = $response.response -replace "`r",""

# Split por delimitador "### " y filtrar bloques no vacíos
$blocks = $raw -split "(?m)^###\s+" | Where-Object { $_.Trim().Length -gt 0 }

# Expresión para extraer nombre de archivo en la primera línea y contenido en las siguientes
foreach ($block in $blocks) {
    # Separar la primera línea (nombre) del resto (contenido)
    $lines = $block -split "`n",2
    if ($lines.Count -ge 2) {
        $filenameLine = $lines[0].Trim()
        $content = $lines[1].Trim("`n","`r"," ")
        # Normalizar nombre de archivo (quitar caracteres inválidos)
        $filename = $filenameLine -replace '[\\/:*?"<>|]','' 
        if ($filename -ne "") {
            # Si el nombre no tiene extensión y parece markup, podés añadir lógica; aquí se usa tal cual
            $content | Out-File -FilePath $filename -Encoding utf8
            Write-Host "Generado archivo:" $filename
        }
    } else {
        # Si no tiene salto de línea, ignorar o guardar como fallback
        $fallback = $block.Trim()
        if ($fallback.Length -gt 0) {
            $fallback | Out-File -FilePath "response_fallback.txt" -Encoding utf8
            Write-Host "Bloque sin nombre guardado en response_fallback.txt"
        }
    }
}

# Verificar si hay cambios para commitear
# Actualizar índice y comprobar estado
git add .
# Comprobar si hay algo para commitear
$status = git status --porcelain
if ($status.Trim().Length -gt 0) {
    git commit -m "Sitio generado automaticamente con Ollama Granite"
    git push origin main
    Write-Host "Cambios commiteados y pusheados."
} else {
    Write-Host "No hay cambios para commitear."
}
