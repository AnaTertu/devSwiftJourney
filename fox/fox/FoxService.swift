import Foundation

class FoxService {
    
    static let url = URL(string: "https ://randomfox.ca/floof")
        //"https ://picsum.photos/300"
    //  "https ://randomfox.ca/floof"
   //"https ://dog.ceo/api/breeds/image/random")
    
    //public static func getRandomFox(completion: @escaping ( FoxModel? , Error?) -> Void) {
    public static func getRandomFox(completion: @escaping ( FoxModel?) -> Void) {
        
        guard let url else {
            return //completion(nil, NSError(domain: "Invalid URL", code: 100, userInfo: nil))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data else {
                return //completion(nil, NSError(domain: "Invalid URL", code: 100, userInfo: nil))
            }
            
            do {
                let result = try JSONDecoder().decode(FoxModel.self, from: data)
                completion(result)
            } catch {
                //completion(nil )//, error )
                print("Erro ao decodificar JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    public static func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("❌ URL inválida")
            return
        }
        
        var request = URLRequest(url: url)
            request.cachePolicy = .reloadIgnoringLocalCacheData

        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("❌ Erro ao carregar imagem: \(error.localizedDescription)")
                return
            }
            
            guard let data else {
                print("❌ Dados da imagem são nil")
                return
            }
            
            print("✅ Imagem baixada (\(data.count) bytes)")
            completion(data)
            
        }.resume()
    }
    
    public static func getImage(url: URL, completion: @escaping (Data?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data else { return }
            
            completion(data)
            
        }.resume()
    }

}
