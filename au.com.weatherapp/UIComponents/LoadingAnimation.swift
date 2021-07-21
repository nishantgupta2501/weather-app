//
//  LoadingAnimation.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 21/7/21.
//

import Foundation
import UIKit

final class LoadingAnimation {
    private var isLoading = false
    private let container: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    func addLoader(to view: UIView) {
        view.addSubview(container)
        container.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        container.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        container.clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = container.frame
        
        let angle: CGFloat = 45
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        container.layer.mask = gradientLayer
        
        //animation
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 2
        animation.fromValue = -container.frame.width
        animation.toValue = container.frame.width
        animation.repeatCount = Float.infinity
        
        gradientLayer.add(animation, forKey: "")
    }
    
    func stopLoading() {
        if isLoading {
            container.layer.removeAllAnimations()
            container.layer.mask = nil
        }
    }
}
