import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let url = URL(string: "https://github.com/AnaTertu")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "anatertu.github.io", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "github.com/AnaTertu", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "github.com/AnaTertu/devSwiftJourney", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
       // let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
            
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
      

}

