//
//  SeasonViewController.swift
//  ovo
//
//  Created by iOS on 7/16/15.
//
//

import UIKit
import TraktModels

class SeasonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var collectionView: UITableView!
    @IBOutlet weak var titulo: UINavigationItem!
    
    var show : String?
    var season : Int?
    private var episodes : [Episode]?
    
    private let traktHTTPClient = TraktHTTPClient()
    
    func loadSeasonEpisodes() {
        traktHTTPClient.getEpisodes(self.show!, season: self.season!) { [weak self] result in
            if let episodes = result.value {
                self?.episodes = episodes
                self?.collectionView.reloadData()
            }
            else{
                println("oops \(result.error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titulo.title = "Season " + String(self.season ?? 0)
        
        loadSeasonEpisodes()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let index = collectionView.indexPathForSelectedRow(){
            collectionView.deselectRowAtIndexPath(index, animated: true)
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.SeasonCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EpisodeTableViewCell
        
        if let episodios = self.episodes{
            cell.loadEpisode(episodios[indexPath.row])
        }
        
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if segue == Segue.episode_to_show{
            if let cell = sender as? UITableViewCell, indexPath = collectionView.indexPathForCell(cell){
                let vc = segue.destinationViewController as! EpisodeViewController
                vc.episode = episodes?[indexPath.row]
            }
        }
    }
}
