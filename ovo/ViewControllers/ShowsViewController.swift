//
//  ShowsViewController.swift
//  ovo
//
//  Created by iOS on 7/17/15.
//
//

import UIKit

class ShowsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = Reusable.ShowsCell.identifier!
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowsCollectionViewCell
        
        var url:NSURL? = NSURL(string: "http://i62.tinypic.com/2mw9kr9.jpg")
        var data:NSData? = NSData(contentsOfURL : url!)
        
        if let dat = data{
            var imag = UIImage(data : dat)
            cell.load("oVo",image: imag!)
            
        }
        else{
            let imag=UIImage(named: "clock")
            cell.load("oVo",image: imag!)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}