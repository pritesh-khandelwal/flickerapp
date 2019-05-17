//
//  viewControllerDelegate.swift
//  FlickerApp
//
//  Created by Pritesh Khandelwal on 17/05/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import Foundation
import UIKit



// MARK: - UICollectionViewDelegate protocol
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoArr.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCell.identifier, for: indexPath as IndexPath) as! imageCell
        let image = imageTasks[indexPath.row]?.image
        cell.setImage(image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  CGFloat(10 * (numberOfImageinRow - 1))
        let collectionViewSize = collectionView.frame.size.width - padding
        // return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        return CGSize(width: collectionViewSize/CGFloat(numberOfImageinRow), height: collectionViewSize/CGFloat(numberOfImageinRow))
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if(photoArr.count == 0 || dataSouceArr.pages == self.currentPage){
            return CGSize(width: 0, height: 0)
        }else{
            return CGSize(width: collView.bounds.size.width, height: 50)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let fView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerViewReuseIdentifier, for: indexPath)
            return fView
        } else {
            return UICollectionReusableView()
        }
    }
    
    
    
}

//// MARK: - UICollectionViewDelegate
extension ViewController {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //code for prefetch the data
        if(indexPath.row == self.photoArr.count - 2 && indexPath.row > 0){
           // if(indexPath.row == (currentPage * perPage) - 2){
                currentPage = currentPage + 1
                self.apiCall(pageNumber:  currentPage)
           // }
        }else{//opeation logic
            imageTasks[indexPath.row]?.resume()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageTasks[indexPath.row]?.pause()
        
    }
}
