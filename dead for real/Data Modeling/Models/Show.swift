//
//  Show.swift
//  dead for real
//
//  Created by Michael Johnson on 11/23/22.
//

import Foundation

struct topLevel : Codable {

    let setlist : [Setlist]
    
    struct Setlist : Codable {
        let sets : [String:[Set]] // String is just "set" while a Set is

            struct Set : Codable {
                let name : String? // "Set1", "Set2", etc.
                let song : [Song]
                
                    struct Song : Codable {
                        let name: String?
//                        let info : String?
                }
            }
    }
}
