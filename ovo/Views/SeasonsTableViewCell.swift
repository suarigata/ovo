//
//  SeasonsTableViewCell.swift
//  ovo
//
//  Created by iOS on 7/27/15.
//
//

import UIKit
import TraktModels
import Kingfisher
import FloatRatingView

class SeasonsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var numEpisodios: UILabel!
    @IBOutlet weak var estrelinhas: FloatRatingView!
    
    private var task: RetrieveImageTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadSeason(season : Season){
        let placeholder = UIImage(named: "poster")
        if let url = season.poster?.fullImageURL ?? season.poster?.mediumImageURL ?? season.poster?.thumbImageURL {
            task = imagem.kf_setImageWithURL(url, placeholderImage: placeholder)
        }
        else{
            imagem.image = placeholder
        }
        titulo.text = "Season " + String(season.number)
        numEpisodios.text = String(season.episodeCount ?? 0) + " episodes"
        estrelinhas.rating = season.rating!
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        imagem.image = nil
    }
}
