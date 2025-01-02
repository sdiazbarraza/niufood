# Configurar el entorno de Rails
require_relative '../../config/environment'
require 'net/http'
require 'uri'
require 'json'

# Obtener todos los restaurantes
restaurants = Restaurant.pluck(:id, :name)

# Mostrar la lista de restaurantes
puts "Seleccione un restaurante:"
restaurants.each_with_index do |(id, name), index|
  puts "#{index + 1}. #{name} (ID: #{id})"
end

# Obtener la selección del usuario
selected_index = gets.chomp.to_i - 1
if selected_index < 0 || selected_index >= restaurants.length
    puts "Restaurante no encontrado"
    exit
end
selected_restaurant_id = restaurants[selected_index][0]

# Preguntar al usuario qué acción desea realizar
puts "¿Qué desea hacer? (1: Agregar nuevo dispositivo, 2: Cambiar estado de dispositivo, 3: Eliminar dispositivo):"
action = gets.chomp.to_i

# Seleccionar el método HTTP basado en la acción del usuario
http_method = case action
              when 1
                'POST'
              when 2
                'PUT'
              when 3
                'DELETE'
              else
                puts "Acción no válida"
                exit
              end

# Si la acción es cambiar estado o eliminar, mostrar la lista de dispositivos
if action == 2 || action == 3
  # Obtener dispositivos asociados al restaurante seleccionado
  devices = Device.where(restaurant_id: selected_restaurant_id).pluck(:id, :name)

  # Mostrar la lista de dispositivos
  puts "Seleccione un dispositivo:"
  devices.each_with_index do |(id, name), index|
    puts "#{index + 1}. #{name} (ID: #{id})"
  end

  # Obtener la selección de un dispositivo
  selected_device_index = gets.chomp.to_i - 1

  if selected_device_index < 0 || selected_device_index >= devices.length
    puts "Dispositivo no encontrado"
    exit
end
  selected_device_id = devices[selected_device_index][0]
end

# URL de la API a la que deseas conectarte
api_url = 'http://localhost:3000/api/v1/devices'

# Crear la solicitud HTTP
uri = URI.parse(api_url)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = (uri.scheme == 'https')

# Configurar la solicitud según el método HTTP seleccionado
request = case http_method
          when 'POST'
            Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
          when 'PUT'
            Net::HTTP::Put.new("#{uri.path}/#{selected_device_id}", { 'Content-Type' => 'application/json' })
          when 'DELETE'
            Net::HTTP::Delete.new("#{uri.path}/#{selected_device_id}", { 'Content-Type' => 'application/json' })
          else
            puts "Método HTTP no válido"
            exit
          end

# Configurar la solicitud con los datos necesarios
request.body = case http_method
               when 'POST'
                 puts "Ingrese el nombre del nuevo dispositivo:"
                 device_name = gets.chomp
                 puts "Ingrese el estado del nuevo dispositivo (maintenance o active):"
                 device_status = gets.chomp
                 if device_status != 'maintenance' && device_status != 'active'
                    puts "Estado no válido"
                    exit
                 end
                 { name: device_name, restaurant_id: selected_restaurant_id, status: device_status }.to_json
               when 'PUT'
                 puts "Ingrese el nuevo estado del dispositivo:"
                 device_status = gets.chomp
                 if device_status != 'maintenance' && device_status != 'active'
                    puts "Estado no válido"
                    exit
                 end                 
                 { status: device_status }.to_json
               else
                 nil
               end

# Enviar la solicitud y obtener la respuesta
response = http.request(request)

# Imprimir la respuesta de la API
puts "Response from API: #{response.body}"