//
//  ImageLoaderHelper.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 12.03.2022.
//

import Foundation
import UIKit.UIImage
import Combine

protocol ImageLoaderType {
    func loadImage(from imageUrlString: String?,
                   indexPath: IndexPath,
                   placeholderImage: UIImage?,
                   completionHandler: @escaping (UIImage?) -> ())
    
    func prefetchItem(at indexPaths: [IndexPath], for urls: [String?])
    func cancelPrefetching(at indexPaths: [IndexPath])
}

class ImageLoader: ImageLoaderType {
    static let shared = ImageLoader()
    
    private let cache: ImageCacheType
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()
    private var imageProviders = [IndexPath: ProductImageProvider]()
    
    // A serial queue to be able to write the non-thread-safe dictionary
    private let serialQueueForImageProviders = DispatchQueue(label: "imageProviders.queue", attributes: .concurrent)
    
    init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }
    
    /**
     Downloads and returns images through the completion closure to the caller
     - Parameter imageUrlString: The remote URL to download images from
     - Parameter indexPath: A completion handler which return  image parameter.
     - Parameter completionHandler: A completion handler which return  image parameter.
     - Parameter placeholderImage: Placeholder image to display as we're downloading them from the server
     */
    func loadImage(from imageUrlString: String?,
                   indexPath: IndexPath,
                   placeholderImage: UIImage? = UIImage(named: "placeholder"),
                   completionHandler: @escaping (UIImage?) -> ()) {
        
        guard let imageUrlString = imageUrlString else {
            completionHandler(placeholderImage)
            return
        }
        
        guard let url = URL(string: imageUrlString) else {
            completionHandler(placeholderImage)
            return
        }
        
        if let image = cache[url] {
            completionHandler(image)
        }else {
            
            if let provider = getImageProvider(from: indexPath) {
                provider.loadingCompleteHandler = { [weak self] image in
                    guard let self = self else { return }
                    self.cache[url] = image
                    if let _image = image {
                        completionHandler(_image)
                    }else{
                        completionHandler(placeholderImage)
                    }
                    
                }
                return
            }
            
            if let provider = self.createImageProvider(at: indexPath, for: imageUrlString){
                provider.loadingCompleteHandler = { [weak self] image in
                    guard let self = self else { return }
                    self.cache[url] = image
                    if let _image = image {
                        completionHandler(_image)
                    }else{
                        completionHandler(placeholderImage)
                    }
                }
                return
            }
            
            completionHandler(placeholderImage)
        }
    }
    
    func prefetchItem(at indexPaths: [IndexPath], for urls: [String?]){
        for i in 0..<indexPaths.count {
            let _ = createImageProvider(at: indexPaths[i], for: urls[i])
        }
    }
    
    func cancelPrefetching(at indexPaths: [IndexPath]){
        indexPaths.forEach { indexPath in
            if let provider = imageProviders[indexPath] {
                
                provider.cancel()
                
                // Since Swift dictionaries are not thread-safe, we have to explicitly set this barrier to avoid fatal error when it is accessed by multiple threads simultaneously
                let _ = self.serialQueueForImageProviders.sync(flags: .barrier) {
                    self.imageProviders.removeValue(forKey: indexPath)
                }
            }
        }
    }
    
    private func getOrCreateImageProvider(at indexPath: IndexPath, for url: String?) -> ProductImageProvider? {
        if let provider = self.getImageProvider(from: indexPath) {
            return provider
        }else if let provider = self.createImageProvider(at: indexPath, for: url){
            return provider
        }
        return nil
    }
    
    private func createImageProvider(at indexPath: IndexPath, for url: String?) -> ProductImageProvider?{
        
        guard let _url = url else { return nil }
        
        let imageUrl = URL(string: _url)
        let imageProvider = ProductImageProvider(url: imageUrl) { [weak self] image in
            guard let self = self else { return }
            self.cache[imageUrl!] = image
        }
        
        // We want to control the access to no-thread-safe dictionary in case it's being accessed by multiple threads at once
        self.serialQueueForImageProviders.sync(flags: .barrier) {
            self.imageProviders[indexPath] = imageProvider
        }
        
        return imageProvider
    }
    
    private func getImageProvider(from indexPath: IndexPath) -> ProductImageProvider? {
        
        // Reading from the dictionary should happen in the thread-safe manner.
        self.serialQueueForImageProviders.sync(flags: .barrier) {
            return imageProviders[indexPath]
        }
    }
}
