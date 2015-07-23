//
//  SeasonViewController.swift
//  ovo
//
//  Created by iOS on 7/16/15.
//
//

import UIKit

class SeasonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let ids : [String] = ["asdf1", "asd2f", "as3df", "a4dsf", "5asdf", "asdf6"]
    let nomes : [String] = ["Nome1", "Nome2", "Nome3", "Nome4", "Nome5", "Nome6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ids.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.SeasonCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EpisodeTableViewCell
            
        
//        cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        cell.load(ids[indexPath.row], nome: nomes[indexPath.row])
        return cell
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        <#code#>
//    }
}
