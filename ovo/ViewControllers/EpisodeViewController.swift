//
//  EpisodeViewController.swift
//  ovo
//
//  Created by iOS on 7/16/15.
//
//

import UIKit

class EpisodeViewController: UIViewController {

    @IBOutlet weak var imageEpisode: UIImageView!
    @IBOutlet weak var titleEpisode: UILabel!
    @IBOutlet weak var textEpisode: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleEpisode.text = "Episode Title"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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