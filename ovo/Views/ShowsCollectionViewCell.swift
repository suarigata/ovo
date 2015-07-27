//
//  ShowsCollectionViewCell.swift
//  ovo
//
//  Created by iOS on 7/17/15.
//
//

import UIKit
import TraktModels
import Kingfisher

class ShowsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var texto: UILabel!
    
    private var task: RetrieveImageTask?
    
    func loadShow(show: Show){
        let placeholder = UIImage(named: "poster")
        if let url = show.poster?.fullImageURL ?? show.poster?.mediumImageURL ?? show.poster?.thumbImageURL {
            task = imagem.kf_setImageWithURL(url, placeholderImage: placeholder)
        }
        else{
            imagem.image = placeholder
        }
        texto.text = show.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        imagem.image = nil
    }
}
