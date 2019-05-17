//
//  imageManager.swift
//  FlickerApp
//
//  Created by Pritesh Khandelwal on 16/05/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import Foundation
import UIKit


//image maanger delegate
protocol ImageTaskDownloadedDelegate {
    func imageDownloaded(position: Int)
}


class ImageManager {
    
    static var imageCache = NSCache<NSString, UIImage>()
    
    let position: Int
    let url: URL
    let session: URLSession
    let delegate: ImageTaskDownloadedDelegate
    
    var image: UIImage?
    
    private var task: URLSessionDownloadTask?
    private var resumeData: Data?
    
    private var isDownloading = false
    private var isFinishedDownloading = false
    
    init(position: Int, url: URL, session: URLSession, delegate: ImageTaskDownloadedDelegate) {
        self.position = position
        self.url = url
        self.session = session
        self.delegate = delegate
    }
    
    func resume() {
        //check for chache and call completion block
        if let cachedImage = ImageManager.imageCache.object(forKey: url.absoluteString as NSString){
            DispatchQueue.main.async {
                self.image = cachedImage
                self.delegate.imageDownloaded(position: self.position)
            }
            self.isFinishedDownloading = true
        }
        else if !isDownloading && !isFinishedDownloading {
            isDownloading = true
            
            if let resumeData = resumeData {
                task = session.downloadTask(withResumeData: resumeData, completionHandler: downloadTaskCompletionHandler)
            } else {
                task = session.downloadTask(with: url, completionHandler: downloadTaskCompletionHandler)
            }
            
            task?.resume()
        }
    }
    
    func pause() {
        if isDownloading && !isFinishedDownloading {
            task?.cancel(byProducingResumeData: { (data) in
                self.resumeData = data
            })
            
            self.isDownloading = false
        }
    }
    
    
    private func downloadTaskCompletionHandler(url: URL?, response: URLResponse?, error: Error?) {
        if let error = error {
            //print("Error downloading: ", error)
            return
        }
        
        guard let url = url else { return }
        guard let data = FileManager.default.contents(atPath: url.path) else { return }
        guard let image = UIImage(data: data) else { return }
        
        ImageManager.imageCache.setObject(image, forKey: url.absoluteString as NSString)
        
        DispatchQueue.main.async {
            self.image = image
            self.delegate.imageDownloaded(position: self.position)
        }
        
        self.isFinishedDownloading = true
    }
}

