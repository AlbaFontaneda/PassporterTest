# **Passporter TEST**

Proyecto desarrollado con:

>Swift 5.
Xcode 13.
Deployment Target_ 15.0


# **APP**

La App muestra un listado de destinos con su información básica: Cover, nombre y dirección.
El listado puede filtrarse por los nombres de los destinos gracias al serachbar superior.

A la vez podemos seleccionar un destinos del listado y ver un poco más de información sobre el mismo. En esta segunda pantalla se muestra un poco mas visual la imagen asociada al destino, un mapa embebido con la posición del destino además podemos acceder a una app externa para ver la ruta hasta el punto.

# **Desarrollo**

El proyecto se divide en un _Storyboard_ (Main) con dos _ViewController_, uno para el listado de destinos y otro para el detalle de estos mismos.

Los modelos de datos de los objetos que devuelve el back (Destiny, APIResponse, DestinyLocation...)

Un repositorio que es el encargado de realizar las request al backend.

**ViewControllers**
_DestiniesController_: Muestra una tabla con el listado de destinos en celdas customizadas.

_DetailsViewController_: Este controlador muestra más datos de un destino así como un mapview para ver su posición física. Estos datos vienen directamente de un segue de la pantalla anterior por lo que, como este viewcontroller no se comunica con ningún repositorio, no ha sido necesario instanciar ninguna clase más para pedir datos.


**Repositories:**
_DestiniesRepository_: Aquí se declara la request al API con un URLSession. Para parsear los datos se usa JSONDecoder ya que las entidades han sido declaradas como "Codables"
Recalcar que se ha creado un enumerado con genericos _RequestResponse<T>_ para poder tener un mejor manejo de los errores de las respuestas del API.


# **Info adicional**

Para poder hacer las llamadas http segun la api dada ha habido que modificar el info.plist para permitir request "no seguras"
