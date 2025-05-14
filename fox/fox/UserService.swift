import Foundation

class UserService {
    private static let greetigkey: String = "greeting"
    
    var greeting: String
    
    init(greeting: String) {
        self.greeting = greeting
    }
    
    public func change(greeting: String) {
        self.greeting = greeting
        UserDefaults.standard.set(self.greeting, forKey: UserService.greetigkey)
    }
    
    public func getGreeting() -> String {
        return UserDefaults.standard.string(forKey: UserService.greetigkey) ?? "Hello"
    }
}
