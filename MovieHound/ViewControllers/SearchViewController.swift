//
//  SearchViewController.swift
//  MovieHound
//
//  Created by admin on 7/15/16.
//  Copyright © 2016 Micheal Hannan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchTextBox: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultTableView: UITableView!
    
    let cellName = "SearchTableViewCell"
    
    let manager = Manager.managerSharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureTableView()
        
        let cellNib = UINib(nibName: cellName, bundle: nil)
        resultTableView.registerNib(cellNib, forCellReuseIdentifier: cellName)
        
        resultTableView.delegate = self
        resultTableView.dataSource = self
        
//        let testMovie = MovieItemClass()
//        
//        testMovie.MovieTitle = "Toy Story"
//        testMovie.MovieReleaseYear = 2000
//        testMovie.Rating = "G"
//        testMovie.Poster = "http://ia.media-imdb.com/images/M/MV5BMTgwMjI4MzU5N15BMl5BanBnXkFtZTcwMTMyNTk3OA@@._V1_SX300.jpg"
//        
//        manager.searchMovieResults.append(testMovie)
//        
//        let testMovie2 = MovieItemClass()
//        testMovie2.MovieTitle = "Hocus Pocus"
//        testMovie2.MovieReleaseYear = 1993
//        testMovie2.Rating = "PG"
//        testMovie2.Poster = "http://ia.media-imdb.com/images/M/MV5BMTI3MDI2NDc3Ml5BMl5BanBnXkFtZTcwNDQ2MzQyMQ@@._V1_SX300.jpg"
//        
//        manager.searchMovieResults.append(testMovie2)
    }
    
    func configureTableView() {
        //Setup for dynamic row heights
        resultTableView.rowHeight = UITableViewAutomaticDimension
        resultTableView.estimatedRowHeight = 500
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return manager.searchMovieResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellName, forIndexPath: indexPath) as! SearchTableViewCell
        
        cell.MovieTitleLabel.text = "Title: \(manager.searchMovieResults[indexPath.row].MovieTitle)"
        cell.YearReleasedLabel.text = "Released: \(String(manager.searchMovieResults[indexPath.row].MovieReleaseYear))"
        cell.MovieRatingLabel.text = "Rated: \(manager.searchMovieResults[indexPath.row].Rating)"
        
        if let imgData = NSURL(string: manager.searchMovieResults[indexPath.row].Poster)
        {
            if let data = NSData(contentsOfURL: imgData)
            {
                cell.posterImageView.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let imgData = NSURL(string: manager.searchMovieResults[indexPath.row].Poster)
        {
            if let data = NSData(contentsOfURL: imgData)
            {
                let imageStr : String = data.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
                manager.searchMovieResults[indexPath.row].Poster = imageStr
            }
        }
        
        manager.personalMovieCollection.append(manager.searchMovieResults[indexPath.row])
        
        manager.searchMovieResults = []
        
        searchTextBox.text = ""
        
        searchTextBox.placeholder = "Movie Added to Library"
        
        manager.savePersonalCollection()
        
        resultTableView.reloadData()
    }
    
    @IBAction func searchButtonAction(sender: AnyObject)
    {
        manager.searchMovieResults = []
        
        if searchTextBox.text != nil && searchTextBox.text != ""
        {
            manager.getJSONDataSearchResults(searchTextBox.text!)
            {
                self.resultTableView.reloadData()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
