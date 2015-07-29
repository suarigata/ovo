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
    private var favoritos : [Show]?
    private var lista : [Show]?
    private var images : [UIImage] = []
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    func loadShows() {
        traktHTTPClient.getPopularShows { [weak self] result in
            if let shows = result.value {
                self?.shows = shows
                self?.lista = shows // primeira vez mostra popular
                self?.favoritesChanged()
                self?.collectionView.reloadData()
            }
            else{
                println("oops \(result.error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = FavoritesManager.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "favoritesChanged",
            name: name, object: nil)
        
        self.loadShows()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.escolheLista()
    }
    
    func favoritesChanged(){
        
        self.favoritos = []
        if let shows = self.shows{
            let fm = FavoritesManager()
            let identifiers = fm.favoritesIdentifiers
            self.favoritos = shows.filter { (show : Show) -> Bool in
                return identifiers.contains(show.identifiers.trakt)
            }
        }
    }
    
    func escolheLista(){
        self.lista = self.segmentedControl.selectedSegmentIndex == 0 ? self.shows : self.favoritos
        collectionView.reloadData()
    }
    
    @IBAction func changeList(sender: AnyObject){
        escolheLista()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.lista?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = Reusable.ShowsCell.identifier!
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowsCollectionViewCell
        
        if let shows = self.lista{
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
        if segue == Segue.show_to_show{
            if let cell = sender as? UICollectionViewCell, indexPath = collectionView.indexPathForCell(cell){
                let vc = segue.destinationViewController as! SeasonsTableViewController
                if let s = lista{
                    vc.show = s[indexPath.row].identifiers.slug
                    vc.traktId = s[indexPath.row].identifiers.trakt
                }
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