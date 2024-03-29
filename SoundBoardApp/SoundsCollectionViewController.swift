//
//  SoundsCollectionViewController.swift
//  SoundBoardApp
//
//  Created by Kabir Cahill on 2017-11-15.
//  Copyright © 2017 Kabir Cahill. All rights reserved.
//

import UIKit

private let reuseIdentifier = "buttonCell"
private let itemsPerRow = 3

private var buttons:[String] = ["One", "Two", "Three", "Four"]

class SoundsCollectionViewController: UICollectionViewController {

    @IBOutlet var navBarItem: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        //navBarItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(openRecordViewController))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //@IBAction func openRecordView(_ sender: Any) {
     //   let controller = RecordViewController()
       // show(controller, sender: sender)
    //}
    //@objc func openRecordViewController()
    //{
        //1. extend ViewController
        //2. programatically show a new instance of custom VC
    //}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return buttons.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SoundsCollectionViewCell
    
        // Configure the cell
        
        cell.backgroundColor = UIColor.lightGray
        cell.layer.cornerRadius = 6
        
    
        cell.btn.text = buttons[indexPath.row]
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
