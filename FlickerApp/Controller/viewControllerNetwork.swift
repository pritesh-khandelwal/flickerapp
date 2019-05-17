//
//  viewControllerNetwork.swift
//  FlickerApp
//
//  Created by Pritesh Khandelwal on 17/05/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import Foundation
import UIKit

// MARK: - viewController Network handle
extension ViewController{
    func apiCall(pageNumber:Int){
        FlickerApi.fetchImageData(pageNumber: pageNumber, searchString: self.searchString, success: { (obj) in
            DispatchQueue.main.async{
                if(pageNumber == 1){
                    self.dataSouceArr = PhotosArr()
                    self.photoArr = [PhotoRecord]()
                }
                for dummyObj in obj.photos.photo{
                    let photoObj = PhotoRecord()
                    photoObj.name = dummyObj.title
                    photoObj.url = URL(string:"http://farm\(dummyObj.farm).staticflickr.com/\(dummyObj.server)/\(dummyObj.id)_\(dummyObj.secret).jpg")
                    self.photoArr.append(photoObj)
                }
                self.dataSouceArr.photo.append(contentsOf: obj.photos.photo)
                self.finishedFetchingImagesInfo()
            }
        }) { (error) in
            print("error")
        }
    }
    
    func finishedFetchingImagesInfo() {
        DispatchQueue.main.async {
            self.setupImageTasks(totalImages: self.totalImages)
            self.collView?.reloadData()
        }
    }
    
    func setupImageTasks(totalImages: Int) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        for (index,obj) in photoArr.enumerated(){
            if (imageTasks[index] == nil){
                let url = obj.url!
                let imageTask = ImageManager(position: index, url: url, session: session, delegate: self)
                imageTasks[index] = imageTask
                
            }
        }
    }
}
