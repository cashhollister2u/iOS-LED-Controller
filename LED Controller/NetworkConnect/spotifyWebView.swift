//
//  appWebView.swift
//  LED Controller
//
//  Created by Cash Hollister on 5/19/24.
//

import SwiftUI
import WebKit
import Foundation



struct WebView: UIViewRepresentable {
    var url: URL
    var onRedirect: (URL) -> Void

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                // Check if the URL contains code
                if url.absoluteString.contains("code=") {
                    parent.onRedirect(url)
                }
            }
            decisionHandler(.allow)
        }
    }
}

struct FullScreenWebView: View {
    @EnvironmentObject var apiModel: ApiConnectModel
    var url: URL
    var onDismiss: () -> Void
    
    @State private var hasCodeBeenExtracted = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            WebView(url: url) { url in
                if let code = extractUrlCode(from: url), !hasCodeBeenExtracted {
                        hasCodeBeenExtracted = true
                        apiModel.get_user_spotify_refresh_token(auth_code: code)
                        onDismiss()
                    }
            }
            .edgesIgnoringSafeArea(.all)

            Button(action: {
                onDismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.white)
            }
        }
    }
}

func extractUrlCode(from url: URL) -> String? {
    guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
        return nil
    }
    return components.queryItems?.first(where: { $0.name == "code" })?.value
}


