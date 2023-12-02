//
//  FullImageViewRepresentable.swift
//  SpaceX-Ravn
//
//  Created by Leo on 1/12/23.
//

import Foundation
import UIKit
import SwiftUI

struct FullImageViewRepresentable: UIViewRepresentable {
    @Binding var dismissView: Bool
    var imageView = UIImageView(frame: .zero)
    var scrollView = UIScrollView(frame: .zero)
    var closeButton = UIButton(type: .system)
    var wrapperImageView = UIView(frame: .zero)
    
    func makeUIView(context: UIViewRepresentableContext<FullImageViewRepresentable>) -> UIView {
        let view = UIView(frame: .zero)

        view.addSubview(scrollView)
        view.addSubview(closeButton)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.addSubview(wrapperImageView)
        wrapperImageView.backgroundColor = .black
        wrapperImageView.translatesAutoresizingMaskIntoConstraints = false
        
        wrapperImageView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        closeButton.layer.cornerRadius = 20
        closeButton.backgroundColor = .white
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = UIColor.black
        
        imageView.image = UIImage(systemName: "paperplane")
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            wrapperImageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
            wrapperImageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
            wrapperImageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0),
            wrapperImageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0),
            wrapperImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            wrapperImageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1),
            imageView.leadingAnchor.constraint(equalTo: wrapperImageView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: wrapperImageView.trailingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: wrapperImageView.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: wrapperImageView.bottomAnchor, constant: 0)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: FullImageViewRepresentable

        init(_ parent: FullImageViewRepresentable) {
            self.parent = parent
            super.init()
            self.parent.scrollView.delegate = self
            self.parent.closeButton.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            if scrollView == parent.scrollView {
                return parent.wrapperImageView
            }
            return nil
        }
        
        @objc func closeBtnTapped() {
            parent.dismissView = false
        }
    }
}
