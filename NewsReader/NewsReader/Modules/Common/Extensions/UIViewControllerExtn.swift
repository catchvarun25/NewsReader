//
//  UIViewControllerExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 13/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    
    // MARK: Loader Methods -
    private struct AssociatedKeys {
        static var loaderView: UIView?
        static var errorView: NRErrorView?
    }
    
    private var loaderView: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.loaderView) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.loaderView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var errorView: NRErrorView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.errorView) as? NRErrorView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.errorView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showLoader() {
        if loaderView == nil {
            let loader = UIActivityIndicatorView(style: .medium)
            loader.color = .black
            loaderView = loader
            loaderView?.backgroundColor = .primaryBackgroundNR
            
            view.addSubview(loader)
            loader.snp.makeConstraints { make in
                make.directionalEdges.equalToSuperview()
            }
        }
        
        if let loader = loaderView as? UIActivityIndicatorView {
            loader.startAnimating()
            loader.isHidden = false
        }
    }
    
    func hideLoader() {
        if let loader = loaderView as? UIActivityIndicatorView {
            loader.stopAnimating()
            loader.isHidden = true
        }
    }
    
    // MARK: Error Screen Methods -
    
    func showError(message: String?,
                   handler: (() -> Void)? = nil) {
        if errorView == nil {
            let erroView = NRErrorView(message: message ?? AppConstants.Error.kErrorMessage)
            erroView.tryAgainAction = handler
            errorView = erroView
            view.addSubview(erroView)
            erroView.snp.makeConstraints { make in
                make.directionalEdges.equalToSuperview()
            }
        } else {
            errorView?.isHidden = false
        }
    }
    
    func hideError() {
        errorView?.isHidden = true
    }
}
