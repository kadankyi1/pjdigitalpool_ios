//
//  LiveBroadcastView.swift
//  GloryHub
//
//  Created by Shugaban Media on 19/02/2021.
//

import SwiftUI
import WebKit

struct LiveBroadcastView: View {
    // MARK: - PROPERTIES
    @State private var shouldRefresh = false
    
    
    var body: some View {
        VStack{
            Button(action: {
                self.shouldRefresh = true
            }){
                Text("Reload")
            }
            WebView(url: nil, reload: $shouldRefresh)
        }
    }
}

struct LiveBroadcastView_Previews: PreviewProvider {
    static var previews: some View {
        LiveBroadcastView()
    }
}

struct WebView: UIViewRepresentable {

    var url: URL?     // optional, if absent, one of below search servers used
    @Binding var reload: Bool

    private let urls = [URL(string: "https://google.com/")!, URL(string: "https://bing.com")!]
    private let webview = WKWebView()

    fileprivate func loadRequest(in webView: WKWebView) {
        if let url = url {
            webView.load(URLRequest(url: url))
        } else {
            let index = Int(Date().timeIntervalSince1970) % 2
            webView.load(URLRequest(url: urls[index]))
        }
    }

    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        loadRequest(in: webview)
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        if reload {
            loadRequest(in: uiView)
            DispatchQueue.main.async {
                self.reload = false     // must be async
            }
        }
    }
}
