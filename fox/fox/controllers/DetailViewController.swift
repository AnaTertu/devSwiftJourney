import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView! // é como reservar espaço para um quadro, antes dela ser entregue.
    var detailItem: PetitionModal?
    
    override func loadView() {
        webView = WKWebView()   // é como construir um quadro
        view = webView  // é como pendurar o quadro na parede da sala.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        let html = """
            <html>
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale-1">
                    <style> 
                        body { font-size: 120%; font-family: -apple-system, Helvetica, sans-serif; line-height: 1.5; padding: 16px; }
                    </style>
                </head>
                <body>
                    \(detailItem.body)
                </body>
            </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
        
    }
}
