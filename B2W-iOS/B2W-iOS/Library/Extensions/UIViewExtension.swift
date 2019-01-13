//
//  UIViewExtension.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 10/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

extension UIView
{
    static func loadFromXib<T>(withOwner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> T where T: UIView
    {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: withOwner, options: options).first as? T else {
            fatalError("Could not load view from nib file.")
        }
        return view
    }
}

// Autolayout
extension UIView {
    func stretch(view: UIView) {
        var mainView: UIView
        
        switch self {
        case is UITableView, is UICollectionView, is UIScrollView:
            guard let sView = superview else {
                return
            }
            mainView = sView
        default:
            mainView = self
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0).isActive = true
    }
}

// Loading View
extension UIView {
    
    enum BackgroundStyle {
        case color(UIColor)
        case blur(UIBlurEffect.Style)
    }
    
    fileprivate struct AssociatedObjectKeys {
        static var activityIndicator : UInt8 = 0
        static var loadingView : UInt8 = 1
    }
    
    fileprivate var loadingView: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectKeys.loadingView) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectKeys.loadingView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate var activityIndicator: UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectKeys.activityIndicator) as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectKeys.activityIndicator, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate func initLoadingViewWith(loading text: String?,
                                         activityStyle: UIActivityIndicatorView.Style,
                                         backgroundStyle: BackgroundStyle) {
        loadingView = UIView(frame: frame)
        loadingView?.center = center
        loadingView?.alpha = 0.0
        addSubview(loadingView!)
        stretch(view: loadingView!)
        
        switch backgroundStyle {
        case .color(let color):
            loadingView?.backgroundColor = color
        case .blur(let style):
            let blurEffect = UIBlurEffect(style: style)
            let blurredEffectView = UIVisualEffectView(effect: blurEffect)
            blurredEffectView.frame = frame
            loadingView?.addSubview(blurredEffectView)
        }
        
        activityIndicator = UIActivityIndicatorView(style: activityStyle)
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        loadingView?.addSubview(activityIndicator!)
        
        let loadingLabel = UILabel()
        
        if let loadingText = text {
            loadingLabel.translatesAutoresizingMaskIntoConstraints = false
            loadingLabel.text = loadingText
            loadingLabel.textColor = .gray
            loadingView?.addSubview(loadingLabel)
            
            loadingLabel.centerXAnchor.constraint(equalTo: loadingView!.centerXAnchor).isActive = true
            loadingLabel.centerYAnchor.constraint(equalTo: loadingView!.centerYAnchor).isActive = true
            activityIndicator?.centerYAnchor.constraint(equalTo: loadingLabel.centerYAnchor).isActive = true
            activityIndicator?.rightAnchor.constraint(equalTo: loadingLabel.leftAnchor, constant: 10).isActive = true
        } else {
            activityIndicator?.centerXAnchor.constraint(equalTo: loadingView!.centerXAnchor).isActive = true
            activityIndicator?.centerYAnchor.constraint(equalTo: loadingView!.centerYAnchor).isActive = true
        }
        setNeedsUpdateConstraints()
    }
    
    func startLoading(showLabel: Bool = true,
                      activityStyle: UIActivityIndicatorView.Style = .gray,
                      backgroundStyle: BackgroundStyle = .color(.white)) {
        
        if loadingView == nil {
            initLoadingViewWith(loading: showLabel == true ? "Carregando..." : nil,
                                activityStyle: activityStyle,
                                backgroundStyle: backgroundStyle)
        }
        
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
            
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .transitionCrossDissolve,
                           animations: {
                            
                self.loadingView?.alpha = 1.0
            }, completion: nil)
        }
    }
    
    func stopLoading() {
        guard let containerView = loadingView else {return}
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .transitionCrossDissolve,
                           animations: {
                            
                            containerView.alpha = 0.0
            }, completion: { _ in
                self.activityIndicator?.stopAnimating()
            })
        }
    }
    
    func isLoading() -> Bool {
        return activityIndicator?.isAnimating ?? false
    }
}
