//
//  Song.swift
//  dead for real
//
//  Created by Michael Johnson on 8/16/22.
//

import Foundation

struct SongOld : Codable, Equatable {
    
    let name : String
    let year : String?
    var timesPlayed : Int
    var favorite : Bool
    let details : String? //lyrics, history, etc.
}


