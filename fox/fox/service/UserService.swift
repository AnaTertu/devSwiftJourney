import Foundation

class UserService {
    
    public static let shared = UserService()
    
    private static let greetigkey: String = "greeting"
    
    var greeting: String
    
    private init() {
        greeting = ""
    }
    
    public func change(greeting: String?) {
        guard let greeting = greeting else { return }
        self.greeting = greeting
        UserDefaults.standard.set(self.greeting, forKey: UserService.greetigkey)
    }
    
    public func getGreeting() -> String? {
        return UserDefaults.standard.string(forKey: UserService.greetigkey)
    }
}
