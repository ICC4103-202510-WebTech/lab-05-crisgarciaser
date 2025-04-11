# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


User.destroy_all
Chat.destroy_all
Message.destroy_all

first_names = ["Juan", "María", "Carlos", "Ana", "Luis", "Laura", "Pedro", "Sofía", "Diego", "Valentina"]
last_names = ["Gómez", "Rodríguez", "Pérez", "García", "Martínez", "López", "Fernández", "González", "Díaz", "Torres"]

10.times do |i|
  User.create!(
    email: "usuario#{i+1}@ejemplo.com",
    first_name: first_names[i],
    last_name: last_names[i],
    created_at: Time.now,
    updated_at: Time.now
  )
end

user_ids = User.pluck(:id)
10.times do |i|
  sender_id = user_ids[i % user_ids.size]
  receiver_id = user_ids[(i + 1) % user_ids.size]
  
  Chat.create!(
    sender_id: sender_id,
    receiver_id: receiver_id,
    created_at: Time.now,
    updated_at: Time.now
  )
end

chat_ids = Chat.pluck(:id)
sample_messages = [
  "Hola, ¿cómo estás?",
  "¿Qué planes tienes para hoy?",
  "Nos vemos más tarde",
  "Te envié el documento que me pediste",
  "¿Vas a ir a la reunión mañana?",
  "Gracias por tu ayuda",
  "¿Recibiste mi último mensaje?",
  "Por favor llámame cuando puedas",
  "Feliz cumpleaños!",
  "Confirmo que recibí el paquete"
]

10.times do |i|
  Message.create!(
    chat_id: chat_ids[i % chat_ids.size],
    user_id: user_ids[i % user_ids.size],
    body: sample_messages[i],
    created_at: Time.now,
    updated_at: Time.now
  )
end
