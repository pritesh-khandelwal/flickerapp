//
//  imageCell.swift
//  FlickerApp
//
//  Created by Pritesh Khandelwal on 14/05/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import UIKit

class imageCell: UICollectionViewCell {

    @IBOutlet weak var imageCollView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class var identifier: String {
        return "imageCell"
    }
    
//    func setImage(photoObj:PhotoRecord){
//        self.imageCollView.image = photoObj.image
//    }
//
//    func updateImage(imageObj:UIImage?){
//        if let imageValue = imageObj{
//            self.imageCollView.image = imageValue
//        }
//    }
    func setImage(image:UIImage?){
        if let image = image{
            self.imageCollView.image = image
        }else{
            self.imageCollView.image = UIImage(named: "Placeholder")
        }
    }
    
    
    override func prepareForReuse() {
        self.imageCollView.image = nil
    }
    

}
