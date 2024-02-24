//
//  PEGBWKWebview.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import WebKit

public class PEGBWKWebview: UIView {
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.uiDelegate = self
        view.navigationDelegate = self
        view.scrollView.contentInsetAdjustmentBehavior = .never
        view.scrollView.showsVerticalScrollIndicator = false
        view.scrollView.showsHorizontalScrollIndicator = false
        return view
    }()

    private lazy var progressBar: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progressTintColor = .primary
        view.backgroundColor = .lightGray
        return view
    }()

//    var htmlString = "" {
//        didSet {
//            var html = """
//            <!DOCTYPE html>
//            <head>
//              <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
//                <style>
//                  @font-face {
//                    font-family: 'Open Sans';
//                    font-style: normal;
//                    font-weight: 700;
//                    font-stretch: 100%;
//                    font-display: swap;
//                    src: url(https://fonts.gstatic.com/s/opensans/v35/memvYaGs126MiZpBA-UvWbX2vVnXBbObj2OVTSGmu0SC55K5gw.woff2) format('woff2');
//                    unicode-range: U+0100-02AF, U+0304, U+0308, U+0329, U+1E00-1E9F, U+1EF2-1EFF, U+2020, U+20A0-20AB, U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
//                  }
//
//                  body {
//                    font-family: 'Open Sans';
//                    font-weight: 400;
//                  }
//
//                  strong {
//                    font-family: 'Open Sans';
//                    font-weight: 700;
//                  }
//                </style>
//            </head>
//            <body>
//              <meta name="viewport" content="width=device-width,initial-scale=1">
//              \(htmlString)
//            </body>
//            """
//
//            var newContent = html.replacingOccurrences(of: "<table>", with: "<div class =\"custom-table\"><table>")
//            newContent = newContent.replacingOccurrences(of: "</table>", with: "</table></div>")
//
//            html = "<div class=\"app-contents\">" + html + "</div>"
//            html = "<!DOCTYPE html><html><body>\(html)</body></html>"
//
//            webView.loadHTMLString(html, baseURL: nil)
//        }
//    }

    public var url = "" {
        didSet {
            if let urlU = URL(string: url) {
                let urlRequest = URLRequest(url: urlU)
                webView.load(urlRequest)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressBar.progress = Float(webView.estimatedProgress)
            progressBar.isHidden = progressBar.progress == 1
        }
    }

    private func setupViews() {
        setupWebview()
        setupProgressBar()
    }

    private func setupWebview() {
        addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.centerXAnchor.constraint(equalTo: centerXAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupProgressBar() {
        addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: webView.trailingAnchor)
        ])
    }
}

extension PEGBWKWebview: WKNavigationDelegate, WKUIDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { height, _ in
//            let heigtOfWeb = height as! CGFloat
//            self.heightHandler?(heigtOfWeb + 86 + 35 + 30 + 48 + 40)
//        })
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
//        navigationDelegate?.bavWebView?(self, didFinish: navigation)
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        if let function = navigationDelegate?.bavWebView?(self, decidePolicyFor: navigationAction, decisionHandler: decisionHandler) {
//            function
//        } else if navigationAction.navigationType == .linkActivated {
//            if let url = navigationAction.request.url, UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url)
//                decisionHandler(.cancel)
//            } else {
//                decisionHandler(.allow)
//            }
//        } else {
//            decisionHandler(.allow)
//        }
        decisionHandler(.allow)
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
//        navigationDelegate?.bavWebView?(self, didFailProvisionalNavigation: navigation, withError: error)
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}
