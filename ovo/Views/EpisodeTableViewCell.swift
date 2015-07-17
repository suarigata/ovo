//
//  EpisodeTableViewCell.swift
//  ovo
//
//  Created by iOS on 7/16/15.
//
//

import UIKit

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
    
    func load(id : String, nome : String){
        episodio_id.text=id
        episodio_nome.text=nome
    }
}
