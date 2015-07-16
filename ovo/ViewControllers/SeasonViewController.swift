//
//  SeasonViewController.swift
//  ovo
//
//  Created by iOS on 7/16/15.
//
//

import UIKit

class SeasonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SeasonCell", forIndexPath: indexPath) as! EpisodeTableViewCell
            
            
        cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        return cell
    }

}
