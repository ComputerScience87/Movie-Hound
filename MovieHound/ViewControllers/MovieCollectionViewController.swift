//
//  MovieCollectionViewController.swift
//  MovieHound
//
//  Created by admin on 7/15/16.
//  Copyright © 2016 Micheal Hannan. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "MovieCollectionViewCell"
let manager = Manager.managerSharedInstance

var tempMovie : MovieItemClass?

class MovieCollectionViewController: UICollectionViewController {

    @IBOutlet var movieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        let cellNib = UINib(nibName: cellReuseIdentifier, bundle: nil)
        movieCollectionView.registerNib(cellNib, forCellWithReuseIdentifier: cellReuseIdentifier)

        manager.loadPersonalCollection()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return manager.personalMovieCollection.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! MovieCollectionViewCell
        
        cell.movieTitleLabel.text = manager.personalMovieCollection[indexPath.row].MovieTitle
        cell.movieTitleLabel.textColor = UIColor.whiteColor()
        
        let imgData:NSData = NSData(base64EncodedString: manager.personalMovieCollection[indexPath.row].Poster, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
        cell.moviePosterImageView.image = UIImage(data: imgData)
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let imgData:NSData = NSData(base64EncodedString: manager.personalMovieCollection[indexPath.row].Poster, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
        let tempImg : UIImageView = UIImageView(image: UIImage(data: imgData))
        let imgSize = tempImg.sizeThatFits(CGSizeMake(1000, 1000))
        
        let tempLabel = UILabel()
        tempLabel.text = manager.personalMovieCollection[indexPath.row].MovieTitle
        let labelSize = tempLabel.sizeThatFits(CGSizeMake(1000, 1000))
        
       
        
        if labelSize.width > imgSize.width
        {
            var finalSize = CGSizeMake(labelSize.width, ((labelSize.height + imgSize.height) + 10))
            finalSize.height = finalSize.height / 2.3
            finalSize.width = finalSize.width / 2.3
            return finalSize
        }
        else
        {
            var finalSize = CGSizeMake(imgSize.width, ((labelSize.height + imgSize.height) + 10))
            finalSize.height = finalSize.height / 2.3
            finalSize.width = finalSize.width / 2.3
            return finalSize
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        tempMovie = manager.personalMovieCollection[indexPath.row]
        
        performSegueWithIdentifier("MovieDetailSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "MovieDetailSegue"
        {
            let movieDetailInstance : MovieDetailViewController = segue.destinationViewController as! MovieDetailViewController
            
            movieDetailInstance.movieToDisplay = tempMovie
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
