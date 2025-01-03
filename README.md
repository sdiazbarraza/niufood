# Contenido
La aplicación consta de cuatro partes:

* En registro de mantenimiento: Visualizamos el listado de registros de mantenimiento de los dispositivos.
* En dashboard: Visualizamos los dispositivos por restaurant y el estado de los restauranes.
* API de devices: Está para crear, actualizar (el estado) y eliminar dispositivos. Cada endpoint fueron testeados con su respectivo test. Una vez que el estado de los dispositivos cambió es a traves de Sidekiq que encolamos y ejecutamos un Job para actualizar el estado de restaurant. Si el restaurant tiene todos sus dispositivos en `maintenance` el estado del restaurant es en `problemas`; si al menos uno de sus dispositivos está en `m̀aintenance`, el estado del restaurant será `warning`; mientras que si el todos los dispositivos están en `active`, el estado del restaurant será `operativo`
* Script: Quien se encarga de cambiar de estado los dispositivos de los restaurantes seleccionados. Teniendo las opciones de agregar un nuevo dispositivo, actualizar o eliminar, si es necesario. Los cuales de la mano de la api es posible realizar las operaciones indicadas

# Instalaciones previas

## Instalar redis 6 o superior

* Eliminar la versión actual
  
  `sudo apt-get remove --purge redis-server`

* Agregar el repositorio de Redis actualizado
  
  `sudo add-apt-repository ppa:redislabs/redis`
  
  `sudo apt-get update`

* Instalar redis

  `sudo apt-get install redis-server`
# Configurando la aplicación

* Crear las base de datos

  `rails db:create`

* Ejecutar las migraciones

  `rails db:migrate`

* Ejecutar los seed

  `rails db:seed`

# Para iniciar la aplicación

## Iniciar Sidekiq y Redis

* Iniciar el servidor de redis

  `sudo service redis-server start`

* Levantar sidekiq

  `bundle exec sidekiq`
  
## Levantar puma

* Iniciar el servidor

  `bin/rails s`
  
 ## Ejecutar script
 
  `ruby lib/script/devices_to_api.rb`