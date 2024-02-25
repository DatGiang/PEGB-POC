//
//  PEGBWKWebview.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore
import WebKit

public class PEGBWKWebview: UIView, View {
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

    public var url = "" {
        didSet {
            if let urlU = URL(string: url) {
                let urlRequest = URLRequest(url: urlU)
                webView.load(urlRequest)
            }
        }
    }

    public var viewModel: PEGBWkWebViewModel?

    public init(viewModel: PEGBWkWebViewModel?) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
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
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setupProgressBar() {
        addSubview(progressBar)

        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
        ])
    }
}

extension PEGBWKWebview: WKNavigationDelegate, WKUIDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        viewModel?.onLoadFail(with: error)
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}
