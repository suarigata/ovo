//
//  SeasonsTableViewController.swift
//  ovo
//
//  Created by iOS on 7/27/15.
//
//

import UIKit
import TraktModels

class SeasonsTableViewController: UITableViewController{
    
    
    @IBOutlet weak var starImage: UIBarButtonItem!
    @IBOutlet var collectionView: UITableView!
    var show : String?
    var traktId : Int?
    var seasons : [Season]?
    
    private let traktHTTPClient = TraktHTTPClient()
    
    func loadSeasons(){
        traktHTTPClient.getSeasons(self.show!) { [weak self] result in
            if let seasons = result.value {
                self?.seasons = seasons
                self?.collectionView.reloadData()
            }
            else{
                println("oops \(result.error)")
            }
        }
    }
    
    override func viewDidLoad() {
        
        let name = FavoritesManager.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "favoritesChanged",
            name: name, object: nil)
        
        loadSeasons()
        favoritesChanged() // da primeira vez para por o certo
    }
    
    deinit{
        let name = FavoritesManager.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: name, object: nil)
    }
    
    func favoritesChanged(){
        let manager = FavoritesManager()
        let favoritos = manager.favoritesIdentifiers
        
        if favoritos.contains(self.traktId!){
            self.starImage.tintColor = UIColor.yellowColor()
        }
        else{
            self.starImage.tintColor = UIColor.whiteColor()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.seasons?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = Reusable.SeasonsCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! SeasonsTableViewCell
        
        if let seasons = self.seasons{
            cell.loadSeason(seasons[indexPath.row])
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.season_to_show{
            if let cell = sender as? SeasonsTableViewCell, indexPath = collectionView.indexPathForCell(cell){
                let vc = segue.destinationViewController as! SeasonViewController
                vc.season = seasons?[indexPath.row].number
                vc.show = self.show
            }
        }
    }
    
    @IBAction func favoritar(sender: AnyObject){
        let manager = FavoritesManager()
        manager.toggle(self.traktId!)
    }
}