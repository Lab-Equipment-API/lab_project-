puts "Clearing old data..."
MaintenanceRecord.destroy_all
Equipment.destroy_all
Category.destroy_all

puts "Seeding categories..."
computing   = Category.create!(name: "Computing")
optics      = Category.create!(name: "Optics")
networking  = Category.create!(name: "Networking")
electronics = Category.create!(name: "Electronics")

puts "Seeding equipment..."
laptop    = Equipment.create!(name: "Dell Laptop",        serial_number: "LAP-001", status: "available",   category: computing)
arduino   = Equipment.create!(name: "Arduino Mega",       serial_number: "ARD-002", status: "in_use",      category: electronics)
router    = Equipment.create!(name: "Cisco Router",       serial_number: "NET-003", status: "maintenance", category: networking)
scope     = Equipment.create!(name: "Optical Microscope", serial_number: "MIC-004", status: "available",   category: optics)
switch    = Equipment.create!(name: "Network Switch",     serial_number: "NET-005", status: "in_use",      category: networking)
pi        = Equipment.create!(name: "Raspberry Pi",       serial_number: "ARD-006", status: "available",   category: electronics)
projector = Equipment.create!(name: "Lab Projector",      serial_number: "OPT-007", status: "maintenance", category: optics)
desktop   = Equipment.create!(name: "HP Desktop",         serial_number: "LAP-008", status: "available",   category: computing)

puts "Seeding maintenance records..."
MaintenanceRecord.create!(description: "Replaced cracked screen",         performed_at: 3.days.ago,  equipment: laptop)
MaintenanceRecord.create!(description: "Flashed new firmware",            performed_at: 1.week.ago,  equipment: arduino)
MaintenanceRecord.create!(description: "Reset configuration to defaults", performed_at: 2.weeks.ago, equipment: router)
MaintenanceRecord.create!(description: "Cleaned optical lens assembly",   performed_at: 5.days.ago,  equipment: scope)
MaintenanceRecord.create!(description: "Reconfigured VLAN settings",      performed_at: 1.day.ago,   equipment: router)

puts "Done!"
puts "Categories: #{Category.count}"
puts "Equipment: #{Equipment.count}"
puts "MaintenanceRecords: #{MaintenanceRecord.count}"
