import WebKit
import UIKit

class ViewController: UIViewController {
    
    var webView: WKWebView!
                // visualização de carregamento
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
                //visualização Carregou
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let url = URL(string: "https://github.com/AnaTertu")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
                // Visualização Aparecerá
    override func viewWillAppear(_ animated: Bool) {
        /* super.viewWillAppear(animated)
        let url = URL(string: "https: //www.google.com.br")!
        webView.load(URLRequest(url: url)) */
    }
    
    /* func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Carregou")
    } */
                
    func viewDidAppear() {} // Vizualização Apareceu
    
    func viewDidDisappear() {}  // Vizualização Desapareceu

}

extension ViewController : WKNavigationDelegate {
    
}
