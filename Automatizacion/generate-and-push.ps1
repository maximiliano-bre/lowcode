# 1. Leer prompt desde archivo como string plano
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

# 5. Guardar en archivos
$response.response | Out-File -FilePath "Generated.aspx" -Encoding utf8
$response.response | Out-File -FilePath "Generated.cs" -Encoding utf8

# 6. Subir al GitHub
git add Generated.aspx Generated.cs
git commit -m "Sitio generado automáticamente con Ollama Granite"
git push origin main