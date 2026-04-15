Para generar una página web simple que muestre "Hola Mundo" con estilos básicos de centrado, también incluye un alert al cargar la página, podemos seguir los siguientes pasos:

1. Crear el archivo index.html y escribir el código HTML básico para crear una página web simple que muestre el texto "Hola Mundo". Aquí está el código:

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hola Mundo</title>
    <link rel="stylesheet" href="style.css">
</head>
<body onload="showAlert()">
    <h1>Hola Mundo</h1>

    <script src="script.js"></script>
</body>
</html>
```
2. Crear el archivo style.css y escribir el código CSS para centrar el texto en la página. Aquí está el código:

```css
h1 {
    text-align: center;
}
```

3. Crear el archivo script.js y escribir el código JavaScript que muestra un alert al cargar la página. Aquí está el código:

```javascript
function showAlert() {
    alert('Hola Mundo');
}
```

Este es el código completo para generar una página web simple que muestre "Hola Mundo" con estilos básicos de centrado y un alert al cargar la página. Abre el archivo index.html en un navegador para ver el resultado.

