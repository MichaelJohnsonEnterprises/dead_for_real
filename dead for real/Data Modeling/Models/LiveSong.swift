//
//  LiveSong.swift
//  dead for real
//
//  Created by Michael Johnson on 12/3/22.
//

import Foundation

struct LiveSong : Codable, Equatable {
    
    let name : String
    let year : String?
    var timesPlayed : Int
    var favorite : Bool
    let details : String? //lyrics, history, etc.
    
}
