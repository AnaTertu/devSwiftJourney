import UIKit

class AppleDevice {
    var name: String
    var description: String
    var isSelected: Bool
    var label: Int?
    
    init(name: String, description: String, isSelected: Bool = false, label: Int?) {
        self.name = name
        self.description = description
        self.isSelected = isSelected
        self.label = label
    }
}

extension AppleDevice: Identifiable {
    var id: Int {
        label = 0
        return label ?? 0
    }
    
    func incrementDevice() {
        
        if let label = label {
            self.label = label + 1
        }
    }
}

class Devices {
    var allDevices: [AppleDevice] = [
        AppleDevice(name: "Product name", description: "Product description brand", label: 0),
        AppleDevice(name: "Product name", description: "Product descriptionbrand", label: 0),
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
    
    func updateDevice(_ device: AppleDevice, at indexPath: IndexPath) {
        allDevices[indexPath.row] = device
    }
    
    func selectDevice(at indexPath: IndexPath) {
        allDevices[indexPath.row].isSelected.toggle()
    }
    
}
