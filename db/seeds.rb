# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

juan = User.create(email: "juan.perez@live.com", username: "juan.p", password: "1234")
ana = User.create(email: "ana.diaz@live.com", username: "ana.d", password: "1234")

regular_link = RegularLink.create(url: "https://github.com/bautimercado/chq-to",
                                  name: "Regular",
                                  user: juan)

temporal_link = TemporalLink.create(url: "https://catedras.linti.unlp.edu.ar/pluginfile.php/133107/mod_resource/content/1/tfi.pdf",
                                    name: "En fecha",
                                    expiration_date: DateTime.new(2024, 12, 31),
                                    user: juan)

temporal_link_expired = TemporalLink.create(url: "https://catedras.linti.unlp.edu.ar/pluginfile.php/133107/mod_resource/content/1/tfi.pdf",
                                            name: "Expirado",
                                            expiration_date: DateTime.new(2023, 01, 01),
                                            user: juan)

private_link = PrivateLink.create(url: "https://rubyonrails.org/",
                                  name: "Contraseña 1234",
                                  password: "1234",
                                  user: juan)

ephimeral_link = EphemeralLink.create(url: "https://github.com/heartcombo/devise",
                                      name: "Accesible",
                                      user: juan)

puts "Seed completed!"