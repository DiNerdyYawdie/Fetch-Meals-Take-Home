//
//  ImageCacheService.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/19/24.
//

import UIKit
import Foundation

protocol ImageCacheService {
    func loadImage(url: URL) async -> UIImage?
    func saveImage(url: URL) async -> UIImage?
}

// MARK: Handle caching for images already downloaded
/// Could also use a 3rd party like SDWebImageSwiftUI to handle caching
class ImageCacheServiceImpl: ImageCacheService {
    
    private var imageCacheDictionary: [URL: UIImage] = [:]
    
    // Fetch image that has already been cached to `imageCacheDictionary`
    func loadImage(url: URL) async -> UIImage? {
        if let savedImage = imageCacheDictionary[url] {
            return savedImage
        } else {
            let downloadedImage = await saveImage(url: url)
            return downloadedImage
        }
    }
    
    // Save UIimage once its been downloaded
    // Then save it to  `imageCacheDictionary`
    func saveImage(url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let uiImage = UIImage(data: data) else { return nil }
            
            imageCacheDictionary[url] = uiImage
            return uiImage
        } catch {
            print(error)
            return nil
        }
        
    }
}

