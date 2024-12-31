restaurant = Restaurant.create(name: "Restaurant 1", status: "operativo")

# Crear dispositivos asociados al restaurante
Device.create([
  { name: "POS 1", status: "active", restaurant: restaurant },
  { name: "POS 2", status: "active", restaurant: restaurant },
  { name: "Impresora", status: "active", restaurant: restaurant }
])

restaurant = Restaurant.create(name: "Restaurant 2", status: "warning")

# Crear dispositivos asociados al restaurante
Device.create([
  { name: "POS 3", status: "active", restaurant: restaurant },
  { name: "POS 4", status: "maintenance", restaurant: restaurant },
  { name: "Impresora", status: "active", restaurant: restaurant }
])

restaurant = Restaurant.create(name: "Restaurant 3", status: "problemas")

# Crear dispositivos asociados al restaurante
Device.create([
  { name: "POS 4", status: "maintenance", restaurant: restaurant },  
])
