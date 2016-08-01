//
//  iTuneAdapter.swift
//  Day12WebServices
//
//  Created by admin on 6/22/16.
//  Copyright © 2016 Micheal Hannan. All rights reserved.
//

import UIKit
import MapKit

class PlacesAdapter: NSObject, NSXMLParserDelegate {
    
    static var adapterSharedInstance = PlacesAdapter()
    
//    var postData = NSMutableArray()
//    var elements = NSMutableDictionary()
//    var element = NSString()
    
    var songTitle : String = ""
    var songArtist : String = ""
    let GoogleAPIKey : String = "AIzaSyA6B4ScQE4wzfjR2_SKDNzPWfeNo3xqJH0"
    
    var annotationArray : [CustomAnnotation] = []
    var movieResults : [MovieItemClass] = []
    
    var dataTask : NSURLSessionDataTask!
    
    private override init() {}
    
    // MARK: - JSON Parsing Functions
    
    func beginParsingJSONMovieData(searchString : String, closure:([MovieItemClass]) -> Void)
    {
        let urlSession = NSURLSession.sharedSession()
        
        movieResults = []
        
        if let dataTask = self.dataTask
        {
            dataTask.cancel()
        }
        
        let stringForURL = searchString.stringByReplacingOccurrencesOfString(" ", withString: "+")
        let url = NSURL(string: "http://www.omdbapi.com/?t=\(stringForURL)&y=&plot=full&r=json")
        
        dataTask = urlSession.dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            if let error = error
            {
                print(error.localizedDescription)
            }
            else if let httpResponse = response as? NSHTTPURLResponse
            {
                if httpResponse.statusCode == 200
                {
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            self.parseJSONMovieData(data!)
                            
                            closure(self.movieResults)
                    })
                    
                }
            }
        })
        
        dataTask.resume()
    }
    
    func parseJSONMovieData(data: NSData?){
        
        do{
            if let data = data, let response = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? [String: AnyObject] {
                
               if response["Title"] != nil
               {
                    let feedMovieTitle = String(response["Title"]!)
                    let feedMovieReleaseYear = String(response["Year"]!)
                    let feedRating = String(response["Rated"]!)
                    let feedReleaseDate = String(response["Released"]!)
                    let feedRuntime = String(response["Runtime"]!)
                    let feedGenre = String(response["Genre"]!)
                    let feedDirector = String(response["Director"]!)
                    let feedWriters = String(response["Writer"]!)
                    let feedActors = String(response["Actors"]!)
                    let feedPlot = String(response["Plot"]!)
                    let feedLanguage = String(response["Language"]!)
                    let feedCountryOfRelease = String(response["Country"]!)
                    let feedPoster = String(response["Poster"]!)
                    
                    
                    let tempMovie : MovieItemClass = MovieItemClass()
                    
                    tempMovie.MovieTitle = feedMovieTitle
                    tempMovie.MovieReleaseYear = feedMovieReleaseYear
                    tempMovie.Rating = feedRating
                    tempMovie.ReleaseDate = feedReleaseDate
                    tempMovie.Runtime = feedRuntime
                    tempMovie.Genre = feedGenre
                    tempMovie.Director = feedDirector
                    tempMovie.Writers = feedWriters
                    tempMovie.Actors = feedActors
                    tempMovie.Plot = feedPlot
                    tempMovie.Language = feedLanguage
                    tempMovie.CountryOfRelease = feedCountryOfRelease
                    tempMovie.Poster = feedPoster
                    
                    movieResults.append(tempMovie)
                }
            }
            else
            {
                print("JSON Error")
            }
        }
        catch let error as NSError
        {
            print("Error Parsing Results:\(error.localizedDescription)")
        }
    }
    
    func beginParsingJSONMapData(placeToSearch : CLLocationCoordinate2D, closure:([CustomAnnotation]) -> Void)
    {
        let urlSession = NSURLSession.sharedSession()
        
        annotationArray = []
        
        //cacelling a task that is alread running
        if let dataTask = self.dataTask{
            dataTask.cancel()
        }
        
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(placeToSearch.latitude),%20\(placeToSearch.longitude)&radius=5000&types=movie_rental&key=\(GoogleAPIKey)")
        
        //create a data task
        dataTask = urlSession.dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            if let error = error
            {
                print(error.localizedDescription)
            }
            else if let httpResponse = response as? NSHTTPURLResponse
            {
                
                if httpResponse.statusCode == 200
                {
                        dispatch_async(dispatch_get_main_queue(),
                        {
                            self.parseJSONDataMapKit(data!)
                            
                            closure(self.annotationArray)
                        })
                        
                }
            }
        })
        
        dataTask.resume()
    }

func parseJSONDataMapKit(data: NSData?)
{
    
    print("parseJSONDataMapKit()")
    
    do{
        if let data = data, let response = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? [String: AnyObject] {
            
            if let results: AnyObject = response["results"]
            {
                for result in results as! [AnyObject]
                {
                    print("Processing Result")
                    let title = String(result["name"]!)
                    let subtitle = String(result["vicinity"]!)
                    let geometry = result["geometry"] as! NSDictionary
                    let location = geometry["location"] as! NSDictionary
                    let latitude = String(location["lat"]!)
                    let longitude = String(location["lng"]!)
                    let rating = String(result["rating"])
                    let icon = String(result["icon"]!)
                    
                    var price_val = -1
                    if let tempPrice = result["price_level"] as? Int {
                        price_val = tempPrice
                    }
                    var price = ""
                    if price_val == -1 {
                        price = "Unknown"
                    } else {
                        price = "\(price_val)"
                    }
                    
                    
                    
                    let tempAnno : CustomAnnotation = CustomAnnotation()
                    tempAnno.coordinate = CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
                    tempAnno.title = title.stringByReplacingOccurrencesOfString("Optional(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "")
                    tempAnno.subtitle = subtitle.stringByReplacingOccurrencesOfString("Optional(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "")
                    tempAnno.rating = rating.stringByReplacingOccurrencesOfString("Optional(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "")
                    tempAnno.icon = icon.stringByReplacingOccurrencesOfString("Optional(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "")
                    tempAnno.price = price.stringByReplacingOccurrencesOfString("Optional(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "")
                    annotationArray.append(tempAnno)
                }
            }
            else
            {
                print("Feed Key not found in Dictionary")
            }
        }
        else
        {
            print("JSON Error")
        }
    }
    catch let error as NSError
    {
        print("Error Parsing Results:\(error.localizedDescription)")
    }
}

}
