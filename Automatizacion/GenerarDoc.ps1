# 1. Ruta del repo local
$repoPath = "C:\Bre\Programacion\MIS APP\antigravity"

# 2. Archivos específicos a incluir
$files = @(
    (Join-Path $repoPath "Login.aspx"),
    (Join-Path $repoPath "Login.aspx.vb"),
    (Join-Path $repoPath "Facturas.aspx"),
    (Join-Path $repoPath "Facturas.aspx.vb"),
    (Join-Path $repoPath "Clientes.aspx"),
    (Join-Path $repoPath "Clientes.aspx.vb")
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
Actuá como un analista técnico senior especializado en sistemas .NET (C#, VB.NET, ASP.NET WebForms/MVC) y bases de datos SQL Server.

Voy a proporcionarte un proyecto de software (código fuente, estructura de carpetas, archivos .aspx, .cs/.vb, scripts SQL, etc.).

Tu tarea es analizar completamente el proyecto y generar documentación técnica clara, profesional y concisa.

IMPORTANTE:
- No expliques el código línea por línea
- No repitas código innecesariamente
- Enfocate en explicar funcionamiento, estructura y lógica del sistema
- Usá lenguaje técnico claro
- Pensá que la documentación será utilizada por otro desarrollador

Generá la documentación con la siguiente estructura EXACTA:

1. Introducción
- Describir qué hace el sistema
- Objetivo principal
- Alcance funcional

2. Arquitectura
- Describir la arquitectura general (capas)
- Tecnologías utilizadas
- Flujo entre frontend, backend y base de datos

3. Estructura del proyecto
- Explicar organización de carpetas
- Describir archivos importantes
- Identificar componentes clave

4. Base de datos
- Listar tablas principales con su propósito
- Describir relaciones importantes
- Explicar Stored Procedures relevantes

5. Flujos del sistema
- Describir los flujos principales paso a paso
- Ejemplo: login, alta, modificación, consultas
- Explicar interacción entre capas

6. Configuración
- Identificar variables importantes (connection string, app settings)
- Dependencias externas
- Requisitos del entorno

7. Instalación
- Pasos claros para ejecutar el sistema
- Configuración necesaria
- Requisitos previos

ADICIONAL:
- Si detectás malas prácticas, mencionarlas brevemente
- Si faltan componentes, indicarlo
- Si hay riesgos (seguridad, SQL Injection, etc.), advertirlo

Formato de salida:
- Claro y ordenado
- Sin relleno innecesario
- Listo para ser usado como documentación técnica real

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
