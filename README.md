## Introducción

El objetivo del sistema es proporcionar una forma fácil y segura de ingresar a la aplicación, así como almacenar y managear información de usuarios. El alcance funcional incluye el login, registro de nuevos usuarios, actualización de información de usuario, y consultas a la base de datos.

## Arquitectura

La arquitectura del sistema se divide en tres capas principales: presentation (interface de usuario), application (lógica de negocios), y data access (acceso a la base de datos). La tecnología utilizada es .NET (C#) para el desarrollo de la aplicación web.

El sistema está diseñado para que sea fácil de mantener y escalar en el futuro. Además, se ha implementado una capa de accesos a datos que permite una comunicación directa con la base de datos.

## Estructura del proyecto

La estructura del proyecto está dividida en las siguientes carpetas:
- App_Code: contiene archivos de código auxiliares, como clases y funciones helper
- Content: contiene páginas web estáticas
- Images: contiene imágenes utilizadas por la aplicación
- Scripts: contiene archivos JavaScript necesarios para el correcto functionamiento del sistema
- Styles: contiene hojas de estilo CSS utilizadas por la aplicación
- Vistas: contiene las páginas web que se mostrarán al usuario
    - Default.aspx: página principal, donde el usuario puede ingresar o realizar otras operaciones
    - Login.aspx: página de inicio de sesión

## Base de datos

La base de datos utilizada es una instancia de SQL Server (Express) en un entorno local. La tabla principal es la "Usuarios", que almacena información sobre cada usuario, incluyendo nombre, dirección de correo electrónico, contraseña y otros detalles. Además, se ha creado una tabla "Clientes" para almacenar información de clientes.

## Flujos del sistema

El flujo principal de ingreso al sistema es el siguiente:
1. El usuario ingresa su nombre de usuario y contraseña en la página Login.aspx.
2. La aplicación verifica que los datos ingresados son correctos.
3. Si los datos son correctos, se crea una sesión para el usuario y se envía al resultado default.aspx.
4. En default.aspx, el usuario puede realizar otras operaciones, como ver su información en la tabla Usuarios y agregar clientes a la tabla Clientes.
5. Si el usuario no ha iniciado sesión, se le redirige a Login.aspx.

## Configuración

La aplicación utiliza una cadena de conexión estática en el archivo Web.config para establecer la conexión con la base de datos. Además, se han configurado las variables de entorno necesarias, como las cadenas de conexión y los app settings, que son values personalizados para cada entorno.

## Instalación

Para ejecutar el sistema, es necesario tener instalado Visual Studio 2019 con .NET Framework 5.3 o superior, así como SQL Server (Express) installed. También es necesario descargar e instalar el paquete NuGet para las dependencias del proyecto.

1. Abra Visual Studio y abre la solución de proyectos.
2. Compruebe que los paquetes NuGet necesarios estén instalados en el proyecto (System.Data.SqlClient).
3. Configure las variables de entorno requeridas en el archivo Web.config.
4. Ejecute el proyecto localmente a través del explorador de soluciones o de la línea de comandos.
5. Abra un navegador y ingrese la dirección URL "http://localhost:XXXXX/Login.aspx" para iniciar sesión en la aplicación.

