//
//  ShowsCollectionViewCell.swift
//  ovo
//
//  Created by iOS on 7/17/15.
//
//

import UIKit

class ShowsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var texto: UILabel!
    
    func load(text : String, image : UIImage){
        imagem.image=image  //UIImage(named: "clock")
        texto.text=text
    }
}
