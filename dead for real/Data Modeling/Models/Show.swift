//
//  Show.swift
//  dead for real
//
//  Created by Michael Johnson on 11/23/22.
//

import Foundation
 
struct MassiveSetlistList : Codable {
    let setlist : [Shows]
    
    init() {
        self.setlist = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.setlist = try container.decode([MassiveSetlistList.Shows].self, forKey: .setlist)
    }
    
    struct Shows : Codable {
        let sets : [String: [Show]]
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<MassiveSetlistList.Shows.CodingKeys> = try decoder.container(keyedBy: MassiveSetlistList.Shows.CodingKeys.self)
            self.sets = try container.decode([String : [MassiveSetlistList.Shows.Show]].self, forKey: MassiveSetlistList.Shows.CodingKeys.sets)
        }
        
        struct Show : Codable {
            let name : String? // "Set1", "Set2", etc.
            let encore : Int?
            let song : [Song]
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<MassiveSetlistList.Shows.Show.CodingKeys> = try decoder.container(keyedBy: MassiveSetlistList.Shows.Show.CodingKeys.self)
                self.name = try container.decodeIfPresent(String.self, forKey: MassiveSetlistList.Shows.Show.CodingKeys.name)
                self.encore = try container.decodeIfPresent(Int.self, forKey: MassiveSetlistList.Shows.Show.CodingKeys.encore)
                self.song = try container.decode([MassiveSetlistList.Shows.Show.Song].self, forKey: MassiveSetlistList.Shows.Show.CodingKeys.song)
            }
            
            struct Song : Codable {
                let name: String
                let info : String?
                
                init(from decoder: Decoder) throws {
                    let container: KeyedDecodingContainer<MassiveSetlistList.Shows.Show.Song.CodingKeys> = try decoder.container(keyedBy: MassiveSetlistList.Shows.Show.Song.CodingKeys.self)
                    self.name = try container.decode(String.self, forKey: MassiveSetlistList.Shows.Show.Song.CodingKeys.name)
                    self.info = try container.decodeIfPresent(String.self, forKey: MassiveSetlistList.Shows.Show.Song.CodingKeys.info)
                }
            }
        }
    }
}
