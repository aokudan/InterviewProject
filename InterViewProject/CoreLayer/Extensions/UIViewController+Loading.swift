//
//  UIViewController+Loading.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 16.03.2022.
//

import Foundation
import UIKit

var vSpinner : UIView?

extension UIViewController {
    func showLoadingIndicator(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeLoadingIndicator() {
        if let _ = vSpinner {
            DispatchQueue.main.async {
                vSpinner?.removeFromSuperview()
                vSpinner = nil
            }
        }
    }
    
    func showAlertMessage(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
