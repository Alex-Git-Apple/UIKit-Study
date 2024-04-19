//
//  ImageLoader.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/19/24.
//

import UIKit

class ImageLoader {
    let imageCache = ImageCache()
    static let shared = ImageLoader()
    
    private init() {}
    
    func downloadImage(url urlString: String) async throws -> UIImage {
        if let cachedEntry = await imageCache.cachedEntry(for: urlString) {
            switch cachedEntry {
            case .finished(let image):
                return image
            case .inProgress(let task):
                return try await task.value
            }
        }
        
        let task = Task {
            return try await NetworkManager.shared.downloadImage(urlString)
        }
        
        await imageCache.addTask(for: urlString, task: task)
        
        do {
            let image = try await task.value
            await imageCache.addImage(for: urlString, image: image)
            return image
        } catch {
            await imageCache.removeFailedTask(for: urlString)
            throw DDError.BadResponseError
        }
    }
    
}


actor ImageCache {
    enum CachedEntry {
        case finished(UIImage)
        case inProgress(Task<UIImage, Error>)
    }
    
    private var cache = [String: CachedEntry]()
    
    func cachedEntry(for url: String) -> CachedEntry? {
        return cache[url]
    }
    
    func addTask(for url: String, task: Task<UIImage, Error>) {
        cache[url] = .inProgress(task)
    }
    
    func addImage(for url: String, image: UIImage) {
        cache[url] = .finished(image)
    }
    
    func removeFailedTask(for url: String) {
        cache[url] = nil
    }
}
