# 1. Leer prompt desde archivo
$prompt = Get-Content ".\prompts\abm-cliente.txt" -Raw

# 2. Escapar comillas y normalizar saltos de línea
$promptEscaped = $prompt.Replace('"','\"').Replace("`r","").Replace("`n","\n")

# 3. Construir el JSON manualmente
$jsonBody = @"
{
  "model": "granite-code:latest",
  "prompt": "$promptEscaped",
  "stream": false
}
"@

# 4. Llamar a Ollama
$response = Invoke-RestMethod -Uri "http://localhost:11434/api/generate" -Method Post -ContentType "application/json" -Body $jsonBody

# 5. Dividir la respuesta en bloques por delimitadores
$blocks = $response.response -split "### "

foreach ($block in $blocks) {
    if ($block -like "Default.aspx*") {
        $content = $block -replace "Default.aspx",""
        $content.Trim() | Out-File -FilePath "Default.aspx" -Encoding utf8
    }
    elseif ($block -like "Default.aspx.cs*") {
        $content = $block -replace "Default.aspx.cs",""
        $content.Trim() | Out-File -FilePath "Default.aspx.cs" -Encoding utf8
    }
}

# 6. Subir al GitHub
git add .
git commit -m "Sitio generado automaticamente con Ollama Granite"
git push origin main
