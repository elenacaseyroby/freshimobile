//
//  HTMLView.swift
//  Freshi
//
//  Created by Casey Roby on 7/27/21.
//

import WebKit
import SwiftUI

struct HTMLView: UIViewRepresentable {
//    @Environment(\.colorScheme) var colorScheme
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
//        webView.backgroundColor = UIColor(Color("background"))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--Add Varela Round & Roboto Font-->
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,500;0,700;0,900&family=Varela+Round&display=swap" rel="stylesheet">

        <style> body {
            font-size: 100%;
            font-family: "Roboto", serif;
        }
        </style>
        <style> @media (prefers-color-scheme: dark) {
            body {
                color: #ffffff;
            }
        }
        </style>
        <style> @media (prefers-color-scheme: light) {
            body {
                color: #242e36;
            }
        }
        </style>
        <style> h1 { font-size: 135%; font-family: "Varela Round", sans-serif; } </style>
        <style> h2 { font-size: 110%; font-family: "Varela Round", sans-serif; } </style>
        <style> h3 { font-size: 110%; font-family: "Roboto", serif; font-weight: 400; } </style>
        <style> h4 { font-size: 95%; font-family: "Roboto", serif; } </style>
        </head>
        <body>
        \(htmlContent)
        </body>
        </html>
        """
        uiView.loadHTMLString(html, baseURL: nil)
    }
}
