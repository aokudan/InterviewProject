//
//  DownloadableImageView.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 15.03.2022.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class DownloadableImageView: ImageView {
    
    var urlString: String?
    
    var imageProvider: ProductImageProvider?
    
    func downloadWithUrlSession(with urlStr: String?,
                                placeholderImage: UIImage? = UIImage(named: "placeholder")) {
    
        image = placeholderImage
        
        guard let urlStr = urlStr, let url = URL(string: urlStr) else {
            return
        }
        
        urlString = urlStr
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        imageProvider = ProductImageProvider(url: url, completion: { [weak self] img in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if self.urlString == urlStr {
                    self.image = img
                }
                imageCache.setObject(img as AnyObject, forKey: url as AnyObject)
            }
            
        })
    }
    
    func cancelLoadingImage() {
        imageProvider?.cancel()
        imageProvider = nil
    }
}
