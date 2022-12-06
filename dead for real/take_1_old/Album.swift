//
//  Album.swift
//  dead for real
//
//  Created by Michael Johnson on 8/16/22.
//

import Foundation
import UIKit

struct Album {
    let songs : [SongOld]
    let releaseYear : Int // use non-string for date comparison
    let albumCoverImage : UIImage
}


