//
//  HeadlinesTableViewCell.swift
//  PlayoTask
//
//  Created by pampana ajay on 11/11/21.
//

import UIKit
import SDWebImage

class HeadlinesTableViewCell: UITableViewCell {

    @IBOutlet weak var imageNewsRef:UIImageView!
    @IBOutlet weak var lblAuthorRef:UILabel!
    @IBOutlet weak var lblTitleRef:UILabel!
    @IBOutlet weak var lblDescriptionRef:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configUI(strImage:String,lblAuthor:String,lblTitle:String,lblDescription:String){
       
        imageNewsRef.sd_setImage(with: URL(string: strImage), completed: nil)
        lblAuthorRef.text = lblAuthor
        lblTitleRef.text = lblTitle
        lblDescriptionRef.text = lblDescription
        
        
    }
    
}
