//
//  ImageCache.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation
import UIKit.UIImage

// Declares in-memory image cache
protocol ImageCacheType: AnyObject {
    // Returns the image associated with a given url
    func image(for url: URL) -> UIImage?
    // Inserts the image of the specified url in the cache
    func insertImage(_ image: UIImage?, for url: URL)
    // Removes the image of the specified url in the cache
    func removeImage(for url: URL)
    // Removes all images from the cache
    func removeAllImages()
    // Accesses the value associated with the given key for reading and writing
    subscript(_ url: URL) -> UIImage? { get set }
}

final class ImageCache: ImageCacheType {

    //that contains images
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    private let lock = NSLock()
    private let config: Config

    public struct Config {
        public let countLimit: Int
        public let memoryLimit: Int

        public static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }

    public init(config: Config = Config.defaultConfig) {
        self.config = config
    }

    public func image(for url: URL) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        // search for image data
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            return image
        }
        
        return nil
    }

    public func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        let decompressedImage = image.decodedImage()

        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(decompressedImage, forKey: url as AnyObject, cost: 1)
    }

    public func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url as AnyObject)
    }

    public func removeAllImages() {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeAllObjects()
    }

    public subscript(_ key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
}
