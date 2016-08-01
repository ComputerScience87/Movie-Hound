//
//  MovieClass.swift
//  MovieHound
//
//  Created by admin on 7/12/16.
//  Copyright © 2016 Micheal Hannan. All rights reserved.
//

import UIKit

class MovieItemClass: NSObject, NSCoding
{
    var MovieTitle : String = ""
    var MovieReleaseYear : String = ""
    var Rating : String = ""
    var ReleaseDate : String = ""
    var Runtime : String = ""
    var Genre : String = ""
    var Director : String = ""
    var Writers : String = ""
    var Actors : String = ""
    var Plot : String = ""
    var Language : String = ""
    var CountryOfRelease : String = ""
    var Poster : String = ""
    
    override init()
    {
        super.init()
        
        MovieTitle = "Default Movie"
        MovieReleaseYear = ""
        Rating = "NR"
        ReleaseDate = "01 Jan 1970"
        Runtime = "0"
        Genre = "Unclassified"
        Director = "Unknown"
        Writers = "Unknown"
        Actors = "Uncredited"
        Plot = "Unknown"
        Language = "Not Specified"
        CountryOfRelease = "Unknown"
        Poster = ""
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init()
        
        MovieTitle = aDecoder.decodeObjectForKey("kMovieTitle") as! String
        MovieReleaseYear = aDecoder.decodeObjectForKey("kMovieReleaseYear") as! String
        Rating = aDecoder.decodeObjectForKey("kRating") as! String
        ReleaseDate = aDecoder.decodeObjectForKey("kReleaseDate") as! String
        Runtime = aDecoder.decodeObjectForKey("kRuntime") as! String
        Genre = aDecoder.decodeObjectForKey("kGenre") as! String
        Director = aDecoder.decodeObjectForKey("kDirector") as! String
        Writers = aDecoder.decodeObjectForKey("kWriters") as! String
        Actors = aDecoder.decodeObjectForKey("kActors") as! String
        Plot = aDecoder.decodeObjectForKey("kPlot") as! String
        Language = aDecoder.decodeObjectForKey("kLanguage") as! String
        CountryOfRelease = aDecoder.decodeObjectForKey("kCountryOfRelease") as! String
        Poster = aDecoder.decodeObjectForKey("kPoster") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(MovieTitle, forKey: "kMovieTitle")
        aCoder.encodeObject(MovieReleaseYear, forKey: "kMovieReleaseYear")
        aCoder.encodeObject(Rating, forKey: "kRating")
        aCoder.encodeObject(ReleaseDate, forKey: "kReleaseDate")
        aCoder.encodeObject(Runtime, forKey: "kRuntime")
        aCoder.encodeObject(Genre, forKey: "kGenre")
        aCoder.encodeObject(Director, forKey: "kDirector")
        aCoder.encodeObject(Writers, forKey: "kWriters")
        aCoder.encodeObject(Actors, forKey: "kActors")
        aCoder.encodeObject(Plot, forKey: "kPlot")
        aCoder.encodeObject(Language, forKey: "kLanguage")
        aCoder.encodeObject(CountryOfRelease, forKey: "kCountryOfRelease")
        aCoder.encodeObject(Poster, forKey: "kPoster")
    }
    
}
