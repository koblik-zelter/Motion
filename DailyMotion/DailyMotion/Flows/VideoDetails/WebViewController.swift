//
//  WebViewController.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {

    private lazy var webView = WKWebView()
    private lazy var loadingIndicator = UIActivityIndicatorView()

    private let videoTitle: String
    private let url: URL

    init(title: String, url: URL) {
        self.videoTitle = title
        self.url = url

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = videoTitle
        navigationItem.largeTitleDisplayMode = .never

        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator, with: [
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        let urlRequest = URLRequest(url: url)
        webView.navigationDelegate = self
        webView.load(urlRequest)
        webView.backgroundColor = .white

        loadingIndicator.startAnimating()
    }

}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator.stopAnimating()
    }
}
