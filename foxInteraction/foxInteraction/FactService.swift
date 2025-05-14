import Foundation

class FactService {
    
    static let url = URL(string: "https://meowfacts.herokuapp.com/?lang=por-br")
    
    public static func getRandomFact(completion: @escaping (FactModel?, Error?) -> Void) {
        
        guard let url else {
            return completion(nil, NSError(domain: "Invalid URL", code: 100, userInfo: nil))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return  completion(nil, NSError(domain: "Invalid URL", code: 100, userInfo: nil))}
            
            do {
                let result = try JSONDecoder().decode(FactModel.self, from: data)
                completion(result , nil)
            } catch {
                
            }
        }.resume()
    }
}

