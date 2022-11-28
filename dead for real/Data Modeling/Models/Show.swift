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
//        let eventDate : String
//        let artist : Artist
        let sets : Sets
        
//        struct Artist : Codable {
//            let name : String
//        }
        
        struct Sets : Codable {
            let set : [[String : [Set]]]
            
            struct Set : Codable {
                let name : String
                let song : [Song]
                
                    struct Song : Codable {
                        let name, info : String
                }
            }
        }
    }
}

//{
//   "type" : "setlists",
//   "itemsPerPage" : 20,
//   "page" : 1,
//   "total" : 2334,
//   "setlist" : [ {
//      "id" : "4bf6af3e",
//      "versionId" : "3b2d5808",
//      "eventDate" : "05-07-2015",
//      "lastUpdated" : "2020-10-29T07:18:58.000+0000",
//      "artist" : {
//         "mbid" : "6faa7ca7-0d99-4a5e-bfa6-1fd5037520c6",
//         "name" : "Grateful Dead",
//         "sortName" : "Grateful Dead",
//         "disambiguation" : "",
//         "url" : "https://www.setlist.fm/setlists/grateful-dead-bd6ad4a.html"
//      },
//      "sets" : {
//         "set" : [ {
//            "name" : "Set 1:",
//            "song" : [ {
//               "name" : "China Cat Sunflower",
//               "info" : "Trey Anastasio and Bruce Hornsby on lead vocals) (>"
//            }, {
//               "name" : "I Know You Rider",
//               "cover" : {
//                  "mbid" : "9be7f096-97ec-4615-8957-8d40b5dcbc41",
//                  "name" : "[traditional]",
//                  "sortName" : "[traditional]",
//                  "disambiguation" : "Special Purpose Artist",
//                  "url" : "https://www.setlist.fm/setlists/traditional-5bd2f7e4.html"
//               },
//               "info" : "Trey Anastasio, Phil Lesh,  Bob Weir, Bruce Hornsby on lead vocals"
//            }, {
//               "name" : "Estimated Prophet",
//               "info" : "Bob Weir on lead vocals"
//            },














//struct Setlist : Codable {
//    var id, versionId, eventDate, lastUpdated : String
//    var artist : Artist
//    var sets : [ShowSet]
//}
//
//struct Artist : Codable {
//    var mbid, name, sortName, disambiguation, url : String
//}
//
//struct ShowSet : Codable {
//    var set : [[String : String]]
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.set = try container.decode([[String : String]].self, forKey: .set)
//    }
//}
//
//struct SetItem : Codable {
//
//    //    var name : String?
//    //    var song : [SongItem]
//    //
//    //    init(from decoder: Decoder) throws {
//    //        let container = try decoder.container(keyedBy: CodingKeys.self)
//    //        self.name = try container.decode(String.self, forKey: .name)
//    //        self.song = try container.decode([SongItem].self, forKey: .song)
//    //    }
//    //
//}
//
//
//struct SongItem : Codable {
//    var name: String
//    var info : String?
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.info = try container.decode(String.self, forKey: .info)
//    }
//
//}


//struct Setlist : Codable {
//    var id, versionId, eventDate, lastUpdated : String
//    var artist : Artist
//    var sets : [ShowSet]
//}
//
//struct Artist : Codable {
//    var mbid, name, sortName, disambiguation, url : String
//}
//
//struct ShowSet : Codable {
//    var set : [[String : String]]
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.set = try container.decode([[String : String]].self, forKey: .set)
//    }
//}
//
//struct SetItem : Codable {
//
//    //    var name : String?
//    //    var song : [SongItem]
//    //
//    //    init(from decoder: Decoder) throws {
//    //        let container = try decoder.container(keyedBy: CodingKeys.self)
//    //        self.name = try container.decode(String.self, forKey: .name)
//    //        self.song = try container.decode([SongItem].self, forKey: .song)
//    //    }
//    //
//}
//
//
//struct SongItem : Codable {
//    var name: String
//    var info : String?
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.info = try container.decode(String.self, forKey: .info)
//    }
//
//}
