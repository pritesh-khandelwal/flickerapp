//
//  ViewController.swift
//  FlickerApp
//
//  Created by Pritesh Khandelwal on 14/05/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collView: UICollectionView!
    var imageTasks = [Int: ImageManager]()
    let searchController = UISearchController(searchResultsController: nil)
    var dataSouceArr = PhotosArr()
    var photoArr = [PhotoRecord]()
    let footerViewReuseIdentifier = "RefreshFooterView"
    var searchString = ""

    
    var totalImages = 0
    var numberOfImageinRow = 2
    var perPage = 20
    var currentPage = 1
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.setup()
        self.addRightBtn()
        self.setSearchBar()
        definesPresentationContext = true
    }
    
// MARK: - ViewController UI SetUp Function
    func setup(){
        self.collView.register(UINib(nibName: "imageCell", bundle: nil), forCellWithReuseIdentifier: imageCell.identifier)
        self.collView.register(UINib(nibName: "CustomFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerViewReuseIdentifier)
        self.collView.delegate = self
        self.collView.dataSource = self
    }
    
    func addRightBtn(){
        let rightButtonItem = UIBarButtonItem.init(
            image: UIImage(named: "menu"),
            style: .done,
            target: self,
            action: #selector(showActionPicker(sender:))
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    func setSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = false
        self.navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
    }
}


// MARK: - Search Result delegate
extension ViewController:UISearchResultsUpdating,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        // If the search bar contains text, filter our data with the string
        if let searchText = searchController.searchBar.text {
            print(searchText)
            if(searchText != "" && searchText.count > 2){
                self.searchString = searchText
                self.currentPage = 1
                self.apiCall(pageNumber: currentPage)
            }
            self.photoArr.removeAll()
            self.collView.reloadData()
            self.imageTasks.removeAll()
        }
    }
}


// MARK: - image manager delegate 
extension ViewController:ImageTaskDownloadedDelegate{
    func imageDownloaded(position: Int) {
        if(photoArr.count >= position){
            self.collView.reloadItems(at: [IndexPath(row: position, section: 0)])
        }
    }
}





// MARK: - Action Sheet picker delegate
extension ViewController{
    @objc func showActionPicker(sender: UIBarButtonItem){
        let alertController = UIAlertController(title: "Change Layout", message: "Select Item for option", preferredStyle: .actionSheet)
        let twoBtn = UIAlertAction(title: "Two", style: .default) { (action:UIAlertAction) in
            self.numberOfImageinRow = 2
            self.collView.collectionViewLayout.invalidateLayout()
        }
        let threeBtn = UIAlertAction(title: "Three", style: .default) { (action:UIAlertAction) in
            self.numberOfImageinRow = 3
            self.collView.collectionViewLayout.invalidateLayout()
        }
        let fourBtn = UIAlertAction(title: "Four", style: .default) { (action:UIAlertAction) in
            self.numberOfImageinRow = 4
            self.collView.collectionViewLayout.invalidateLayout()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            
        }
        alertController.addAction(twoBtn)
        alertController.addAction(threeBtn)
        alertController.addAction(fourBtn)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}








