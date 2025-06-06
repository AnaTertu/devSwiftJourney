import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = [ "anatertu.github.io", "github.com/AnaTertu/devSwiftJourney", "hackingwithswift.com"]
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
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        
        let back = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(goBack))
        let forward = UIBarButtonItem(title: "Avançar", style: .plain, target: self, action: #selector(goForward))
                
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [progressButton, back, forward, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac, animated: true)
    }
    
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @objc func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
           decisionHandler(.cancel)
           return
        }
               
        //let url = navigationAction.request.url
        
        if let host = url.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
            let alert = UIAlertController(title: "Bloqueado", message: "Este site não está na lista permitida.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            
            decisionHandler(.cancel)
        } else {
            decisionHandler(.cancel)
        }
    }
}
