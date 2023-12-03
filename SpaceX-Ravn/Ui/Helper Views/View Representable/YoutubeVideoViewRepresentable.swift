//
//  YoutubeVideoViewRepresentable.swift
//  SpaceX-Ravn
//
//  Created by Leo on 1/12/23.
//

import Foundation
import SwiftUI
import UIKit
import WebKit

struct YoutubeVideoViewRepresentable: UIViewRepresentable {
    public var urlVideo: String
    public var wrapperView: UIView = UIView(frame: .zero)
    public var wkWebView: WKWebView = WKWebView(frame: .zero)
    
    func makeUIView(context: UIViewRepresentableContext<YoutubeVideoViewRepresentable>) -> UIView {
        let view = UIView(frame: .zero)

        view.addSubview(wrapperView)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        
        wrapperView.addSubview(wkWebView)
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            wrapperView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            wkWebView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 0),
            wkWebView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: 0),
            wkWebView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 0),
            wkWebView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: 0)
        ])
        
        wkWebView.load(URLRequest(url: URL(string: urlVideo)!))

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: YoutubeVideoViewRepresentable

        init(_ parent: YoutubeVideoViewRepresentable) {
            self.parent = parent
            super.init()
        }
    }
}

