//
//  WebView.swift
//  Freshi
//
//  Created by Casey Roby on 8/10/21.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let url: String

    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        return wkWebView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}

