//
//  Show.swift
//  dead for real
//
//  Created by Michael Johnson on 11/23/22.
//

import Foundation

struct Setlists : Codable {

    let setlist : [Setlist]
    
    struct Setlist : Codable {
        let sets : [String: [Set]]
        
            struct Set : Codable {
                let name : String? // "Set1", "Set2", etc.
                let encore : Int?
                let song : [Song]
                
                    struct Song : Codable {
                        let name: String
                    //    let info : String?
                }
            }
    }
}
