//
//  EpisodeViewController.swift
//  ovo
//
//  Created by iOS on 7/16/15.
//
//

import UIKit
import TraktModels
import Kingfisher

class EpisodeViewController: UIViewController {

    @IBOutlet weak var imageEpisode: UIImageView!
    @IBOutlet weak var titleEpisode: UILabel!
    @IBOutlet weak var textEpisode: UITextView!
    
    // @IBOutlet var collectionView: UIView! // TODO tirar
    
    private var task: RetrieveImageTask?
    
    var episode : Episode?
    
    func loadEpisode(){
        episode?.screenshot
        if let titulo = self.episode?.title, overview = self.episode?.overview{
            self.titleEpisode.text = titulo
            self.textEpisode.text = overview
            
            let placeholder = UIImage(named: "poster")


            if let url = episode?.screenshot?.fullImageURL ?? episode?.screenshot?.mediumImageURL ?? episode?.screenshot?.thumbImageURL{
                self.task = self.imageEpisode.kf_setImageWithURL(url, placeholderImage: placeholder)
            }
            else{
                self.imageEpisode.image = placeholder
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEpisode()
        
        // Do any additional setup after loading the view.
        //titleEpisode.text = "Episode Title"
        
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