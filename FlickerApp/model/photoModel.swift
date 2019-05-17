//
//  photoModel.swift
//  FlickerApp
//
//  Created by Pritesh Khandelwal on 14/05/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import Foundation
import UIKit


class PhotoRecord {
    var name: String = ""
    var url: URL?
    var image = UIImage(named: "Placeholder")
}

class ApiResponse:Codable{
    var photos:PhotosArr = PhotosArr()
    var stat : String = ""
}

class PhotosArr:Codable{
    var page : Int = 0
    var pages : Int = 0
    var perpage : Int = 0
    var total : String = ""
    var photo:[Photo] = [Photo]()
}

class Photo:Codable{
    var id : String = ""
    var owner  : String = ""
    var secret  : String = ""
    var server  : String = ""
    var farm : Int = 0
    var title  : String = ""
    var ispublic : Int = 0
    var isfriend : Int = 0
    var isfamily : Int = 0
}
