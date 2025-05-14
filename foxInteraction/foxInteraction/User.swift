Userimport Foundation

class User {
    private static let greetigkey: String = "greeting"
    
    var greeting: String
    
    init(greeting: String) {
        self.greeting = greeting
    }
    
    public func change(greeting: String) {
        self.greeting = greeting
        UserDefaults.standard.set(self.greeting, forKey: User.greetigkey)
    }
    
    public func getGreeting() -> String {
        return UserDefaults.standard.string(forKey: User.greetigkey) ?? "Hello"
    }
}
