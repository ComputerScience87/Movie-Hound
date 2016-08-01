//
//  MainMenuViewController.swift
//  MovieHound
//
//  Created by admin on 7/15/16.
//  Copyright © 2016 Micheal Hannan. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var findVideoRetailerButton: UIButton!
    @IBOutlet weak var addOrSearchButton: UIButton!
    @IBOutlet weak var viewCollectionButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.darkGrayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func findVideoRetailerAction(sender: AnyObject)
    {
        performSegueWithIdentifier("MapViewSegue", sender: nil)
    }
    
    @IBAction func addOrSearchFilmButtonAction(sender: AnyObject)
    {
        performSegueWithIdentifier("searchSegue", sender: nil)
    }
    
    
    @IBAction func showLibraryButtonAction(sender: AnyObject)
    {
        performSegueWithIdentifier("MyCollectionSegue", sender: nil)
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
