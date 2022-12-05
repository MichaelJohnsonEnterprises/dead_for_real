//
//  Show.swift
//  dead for real
//
//  Created by Michael Johnson on 11/23/22.
//

import Foundation
 
struct MassiveSetlistList : Codable {
    let setlist : [Show]
    
    init() {
        self.setlist = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.setlist = try container.decode([MassiveSetlistList.Show].self, forKey: .setlist)
    }
    
    struct Show : Codable {
        let sets : [String: [Sets]]
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<MassiveSetlistList.Show.CodingKeys> = try decoder.container(keyedBy: MassiveSetlistList.Show.CodingKeys.self)
            self.sets = try container.decode([String : [MassiveSetlistList.Show.Sets]].self, forKey: MassiveSetlistList.Show.CodingKeys.sets)
        }
        
        struct Sets : Codable {
            let name : String? // "Set1", "Set2", etc.
            let encore : Int?
            let song : [Song]
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<MassiveSetlistList.Show.Sets.CodingKeys> = try decoder.container(keyedBy: MassiveSetlistList.Show.Sets.CodingKeys.self)
                self.name = try container.decodeIfPresent(String.self, forKey: MassiveSetlistList.Show.Sets.CodingKeys.name)
                self.encore = try container.decodeIfPresent(Int.self, forKey: MassiveSetlistList.Show.Sets.CodingKeys.encore)
                self.song = try container.decode([MassiveSetlistList.Show.Sets.Song].self, forKey: MassiveSetlistList.Show.Sets.CodingKeys.song)
            }
            
            struct Song : Codable {
                let name: String
                let info : String?
                
                init(from decoder: Decoder) throws {
                    let container: KeyedDecodingContainer<MassiveSetlistList.Show.Sets.Song.CodingKeys> = try decoder.container(keyedBy: MassiveSetlistList.Show.Sets.Song.CodingKeys.self)
                    self.name = try container.decode(String.self, forKey: MassiveSetlistList.Show.Sets.Song.CodingKeys.name)
                    self.info = try container.decodeIfPresent(String.self, forKey: MassiveSetlistList.Show.Sets.Song.CodingKeys.info)
                }
            }
        }
    }
}
