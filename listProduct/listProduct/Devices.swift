import Foundation

class AppleDevice {
    let name: String
    let description: String
    let systemImageName: String
    var isSelected: Bool
    
    init(name: String, description: String, systemImageName: String, isSelected: Bool = false) {
        self.name = name
        self.description = description
        self.systemImageName = systemImageName
        self.isSelected = isSelected
    }
}

class Devices {
    var allDevices: [AppleDevice] = [
        AppleDevice(name: "iPhone 12 mini", description: "6.1-inch Liquid Retina HD display", systemImageName: "iphone"),
        AppleDevice(name: "iPhone", description: "Liquid Retina HD", systemImageName: "iphone"),
    ]
    
    func allDevices(_ device: AppleDevice) {
        allDevices.append(device)
    }
    
    func removeDevice(from indexPath: IndexPath) {
        allDevices.remove(at: indexPath.row)
    }
    
    func getDevice(from indexPath: IndexPath) -> AppleDevice {
        allDevices[indexPath.row]
    }
}
