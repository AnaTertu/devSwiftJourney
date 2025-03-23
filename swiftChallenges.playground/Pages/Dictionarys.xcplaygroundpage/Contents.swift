import Foundation
// Dictionary - coleções não ordenadas de associações de chave-valor

// Dictionary<Key, Value> || Dictionary<String, Int> [Key: Value] || [String: Int]

var namesOfIntergers: [String: Int] = [:]
    
namesOfIntergers = ["Alice": 1, "Bob": 2]
namesOfIntergers["Charlie"] = 3
namesOfIntergers
namesOfIntergers.count
namesOfIntergers = [:]

var airports: [String: String] = [:]
airports["JFK"] = "New York"
airports["LHR"] = "London"
airports["SFO"] = "San Francisco"

if airports["JFK"] != nil {
    airports["JFK"] = "New York City"
    print(airports)
}

if airports.isEmpty {
    print( "No airports defined yet.")
} else {
    print( "Airport definitions exist for \(airports.count).")
}

airports["DUB"] = "Dublin"

airports
airports.count

airports["APL"] = "Apple International Airport"

airports
airports.count

airports["APL"] = nil

airports
airports.count

print("List of airports: ")
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    print("\(airportCode)")
}

for airportName in airports.values {
    print("\(airportName)")
}

let airportCodes = [String](airports.keys)
let airportNames = [String](airports.values)

var implicitoLiteralAirports = ["JFK": "New York", "LHR": "London", "SFO": "San Francisco"]

if let oldValue = implicitoLiteralAirports.updateValue("New York City", forKey: "JFK") {
    print("Old value for JFK: \(oldValue)")
}

implicitoLiteralAirports
implicitoLiteralAirports.count

if let londonAirport = implicitoLiteralAirports["LHR"] {
    print("London airport: \(londonAirport)")
} else {
    print("London airport not found.")
}

implicitoLiteralAirports["APL"] = "Apple International Airport"
implicitoLiteralAirports
implicitoLiteralAirports.count

if let removeValue = implicitoLiteralAirports.removeValue(forKey: "APL") {
    print( "Removed airport: \(removeValue)")
} else {
    print( "Airport not found.")
}
implicitoLiteralAirports
implicitoLiteralAirports.count
