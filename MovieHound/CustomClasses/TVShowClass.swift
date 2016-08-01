//
//  TVShowClass.swift
//  MovieHound
//
//  Created by admin on 7/12/16.
//  Copyright © 2016 Micheal Hannan. All rights reserved.
//

import UIKit

class TVShowClass: NSObject, NSCoding
{
    var ShowTitle : String = ""
    var YearsRun : String = ""
    var Rating : String = ""
    var ReleaseDate : String = ""
    var Runtime : String = ""
    var Genre : String = ""
    var Director : String = ""
    var Writers : String = ""
    var Actors : String = ""
    var Plot : String = ""
    var Language : String = ""
    var CountryOfOrigin : String = ""
    var Poster : String = ""
    var TotalSeasons : String = ""
    
    required init(coder aDecoder: NSCoder)
    {
        super.init()
        
        ShowTitle = aDecoder.decodeObjectForKey("kShowTitle") as! String
        YearsRun = aDecoder.decodeObjectForKey("kYearsRun") as! String
        Rating = aDecoder.decodeObjectForKey("kRating") as! String
        ReleaseDate = aDecoder.decodeObjectForKey("kReleaseDate") as! String
        Runtime = aDecoder.decodeObjectForKey("kRuntime") as! String
        Genre = aDecoder.decodeObjectForKey("kGenre") as! String
        Director = aDecoder.decodeObjectForKey("kDirector") as! String
        Writers = aDecoder.decodeObjectForKey("kWriters") as! String
        Actors = aDecoder.decodeObjectForKey("kActors") as! String
        Plot = aDecoder.decodeObjectForKey("kPlot") as! String
        Language = aDecoder.decodeObjectForKey("kLanguage") as! String
        CountryOfOrigin = aDecoder.decodeObjectForKey("kCountryOfOrigin") as! String
        Poster = aDecoder.decodeObjectForKey("kPoster") as! String
        TotalSeasons = aDecoder.decodeObjectForKey("kTotalSeasons") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(ShowTitle, forKey: "kShowTitle")
        aCoder.encodeObject(YearsRun, forKey: "kYearsRun")
        aCoder.encodeObject(Rating, forKey: "kRating")
        aCoder.encodeObject(ReleaseDate, forKey: "kReleaseDate")
        aCoder.encodeObject(Runtime, forKey: "kRuntime")
        aCoder.encodeObject(Genre, forKey: "kGenre")
        aCoder.encodeObject(Director, forKey: "kDirector")
        aCoder.encodeObject(Writers, forKey: "kWriter")
        aCoder.encodeObject(Actors, forKey: "kActors")
        aCoder.encodeObject(Plot, forKey: "kPlot")
        aCoder.encodeObject(Language, forKey: "kLanguage")
        aCoder.encodeObject(CountryOfOrigin, forKey: "kCountryOfOrigin")
        aCoder.encodeObject(Poster, forKey: "kPoster")
        aCoder.encodeObject(TotalSeasons, forKey: "kTotalSeasons")
    }
    
    override init()
    {
        super.init()
        
        ShowTitle = ""
        YearsRun = ""
        Rating = ""
        ReleaseDate = ""
        Runtime = ""
        Genre = ""
        Director = ""
        Writers = ""
        Actors = ""
        Plot = ""
        Language = ""
        CountryOfOrigin = ""
        Poster = ""
        TotalSeasons = "0"
    }
}
