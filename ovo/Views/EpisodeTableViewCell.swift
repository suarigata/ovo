//
//  EpisodeTableViewCell.swift
//  ovo
//
//  Created by iOS on 7/16/15.
//
//

import UIKit
import TraktModels

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodio_id: UILabel!
    @IBOutlet weak var episodio_nome: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadEpisode(episode: Episode){
        episodio_nome.text = episode.title
        let s = episode.seasonNumber
        let n = episode.number
        episodio_id.text="S" + (s < 10 ? "0" : "") + String(s) + "E" + (n < 10 ? "0" : "") + String(n)
    }
}
