//
//  ShowsViewController.swift
//  ovo
//
//  Created by iOS on 7/17/15.
//
//

import UIKit
import TraktModels

class ShowsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let traktHTTPClient = TraktHTTPClient()
    private var shows : [Show]?
    private var images : [UIImage] = []
    
    func loadShows() {
        traktHTTPClient.getPopularShows { [weak self] result in
            if let shows = result.value {
                self?.shows = shows
                self?.collectionView.reloadData()
            }
            else{
                println("oops \(result.error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadShows()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.shows?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = Reusable.ShowsCell.identifier!
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowsCollectionViewCell
        
        if let shows = self.shows{
            cell.loadShow(shows[indexPath.row])
        }
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let border = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let maxPerRow = floor((collectionView.bounds.width - border) / itemSize)
        let usedSpace = border + itemSize * maxPerRow
        let space = floor((collectionView.bounds.width - usedSpace) / 2)
        return UIEdgeInsets(top: flowLayout.sectionInset.top, left: space,
            bottom: flowLayout.sectionInset.bottom, right: space)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.shows_to_show{
            if let cell = sender as? UICollectionViewCell, indexPath = collectionView.indexPathForCell(cell){
                let vc = segue.destinationViewController as! SeasonViewController
                vc.show = shows?[indexPath.row].identifiers.slug
            }
        }
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