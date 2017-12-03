# CRMApp
Aplicación móvil en Swift que presenta una serie de tablas con información de una aplicación web
Un CRM es una aplicación que usan las empresas para gestionar las relaciones con sus clientes, planificar las visitas que deben realizar los vendedores a los clientes, fijar objetivos, analizar resultados, etc.

El objetivo de esta práctica es crear una app iOS usando el lenguaje Swift que muestre tres listados diferentes de visitas de la página https://dcrmt.herokuapp.com donde está desplegado el prototipo de un servicio CRM:

- Listado con las visitas planificadas para todos los vendedores.
  Puede obtenerse el JSON de estas visitas usando la petición https://dcrmt.herokuapp.com/api/visits/flattened.
- Listado con las visitas planificadas para el usuario o vendedor propietario del token de acceso.
  Puede obtenerse el JSON de estas visitas usando la petición https://dcrmt.herokuapp.com/api/users/tokenOwner/visits/flattened.
- Listado de todas las visitas que he marcado como favoritas (estrellita amarilla).
  Puede obtenerse el JSON de estas visitas usando las peticiones anteriores y metiendo en la query la variable favourites=1.
  
Dado que el número de visitas totales que están almacenadas en el servidor puede ser muy grande, se muestran solo las visitas planificadas entre las dos fechas que se seleccionarán previamente. 
