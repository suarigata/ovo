//
//  SeasonsTableViewController.swift
//  ovo
//
//  Created by iOS on 7/27/15.
//
//

import UIKit

class SeasonsTableViewController: UITableViewController{
    
    var show : String?
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = Reusable.SeasonsCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! SeasonsTableViewCell
        
//        if let episodios = self.episodes{
//            cell.loadEpisode(episodios[indexPath.row])
//        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue == Segue.season_to_show{
//            if let cell = sender as? UICollectionViewCell, indexPath = collectionView.indexPathForCell(cell){
//                let vc = segue.destinationViewController as! SeasonViewController
//                vc.show = shows?[indexPath.row].identifiers.slug
//            }
//        }
    }
}