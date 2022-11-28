//
//  SongDetailViewController.swift
//  dead for real
//
//  Created by Michael Johnson on 8/16/22.
//

import Foundation
import UIKit

class SongDetailViewController : UIViewController {
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var songTitleLabel: UILabel!
    
    func setSongTitleLabelText(text : String) {
        self.songTitleLabel.text = text
    }
    
    func setSeparatorColor(color : UIColor) {
        self.separatorView.backgroundColor = color
    }
}
