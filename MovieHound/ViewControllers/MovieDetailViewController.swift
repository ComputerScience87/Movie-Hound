//
//  MovieDetailViewController.swift
//  MovieHound
//
//  Created by admin on 7/17/16.
//  Copyright © 2016 Micheal Hannan. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MovieDetailViewController: UIViewController {

    var movieToDisplay : MovieItemClass?
    
    
    @IBOutlet weak var MovieNameLabel: UILabel!
    @IBOutlet weak var MovieReleaseYearLabel: UILabel!
    @IBOutlet weak var RatingLabel: UILabel!
    @IBOutlet weak var ReleaseDateLabel: UILabel!
    @IBOutlet weak var RuntimeLabel: UILabel!
    @IBOutlet weak var GenreLabel: UILabel!
    @IBOutlet weak var DirectorLabel: UILabel!
    @IBOutlet weak var WritersLabel: UILabel!
    @IBOutlet weak var ActorsLabel: UILabel!
    @IBOutlet weak var PlotLabel: UILabel!
    @IBOutlet weak var LanguageLabel: UILabel!
    @IBOutlet weak var CountryOriginLabel: UILabel!
    
    @IBOutlet weak var PosterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        MovieNameLabel.text = "\(MovieNameLabel.text): \(movieToDisplay?.MovieTitle)".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        MovieReleaseYearLabel.text = "\(MovieReleaseYearLabel.text): \(movieToDisplay?.MovieReleaseYear)".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        RatingLabel.text = "\(RatingLabel.text): \(movieToDisplay?.Rating)".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        ReleaseDateLabel.text = "\(ReleaseDateLabel.text): \(movieToDisplay?.ReleaseDate)".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        RuntimeLabel.text = "\(RuntimeLabel.text): \(movieToDisplay?.Runtime)".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        GenreLabel.text = "\(GenreLabel.text): \(movieToDisplay?.Genre)".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        DirectorLabel.text = "\(DirectorLabel.text): \(movieToDisplay?.Director)".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        WritersLabel.text = "\(WritersLabel.text): \(movieToDisplay?.Writers)".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        ActorsLabel.text = "\(ActorsLabel.text): \(movieToDisplay?.Actors)".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        PlotLabel.text = "\(PlotLabel.text): \(movieToDisplay?.Plot)".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        LanguageLabel.text = "\(LanguageLabel.text): \(movieToDisplay?.Language)".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        CountryOriginLabel.text = "\(CountryOriginLabel.text): \(movieToDisplay?.CountryOfRelease)".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        let imgData:NSData = NSData(base64EncodedString: (movieToDisplay?.Poster)!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
        PosterImageView.image = UIImage(data: imgData)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showTrailerButtonAction(sender: AnyObject)
    {
        let sampleURL = "http://trailers.apple.com/movies/wb/harrypotterandthedeathlyhallowspart2/harrypotterhallows2-tlr1_h480p.mov"
        let url = NSURL(string: sampleURL)
        let player = AVPlayer(URL: url!)
        
        let moviePlayerVC : AVPlayerViewController = AVPlayerViewController()
        
        moviePlayerVC.player = player
        
        self.presentViewController(moviePlayerVC, animated: true)
        {
            moviePlayerVC.player?.play()
        }
    }
    
    @IBAction func shareToSocialMediaButtonAction(sender: AnyObject)
    {
        let imgData : NSData = NSData(base64EncodedString: (movieToDisplay?.Poster)!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
        let iconImage = UIImage(data: imgData)
        
        let postText : String = "I Recommend the Following Film!\n\nTitle: \(movieToDisplay?.MovieTitle)\nRated: \(movieToDisplay?.Rating)\nReleased: \(movieToDisplay?.MovieReleaseYear)\n\nShared via Movie Hound".stringByReplacingOccurrencesOfString("Optional(\"", withString: "").stringByReplacingOccurrencesOfString("\")", withString: "")
        
        let activityItems : NSArray = [postText, iconImage!]
        
        let activityController : UIActivityViewController = UIActivityViewController(activityItems: activityItems as [AnyObject], applicationActivities: nil)
        
        self.presentViewController(activityController, animated: true, completion: nil)
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
