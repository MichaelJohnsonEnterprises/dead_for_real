//
//  DataCreator.swift
//  dead for real
//
//  Created by Michael Johnson on 8/20/22.
//

import Foundation

// setlistFM API key: _RYJGzYOFgqCITzykUaPqaidvqCFkdl6RNa2

class DataCreator {
    
    var commonSongsList : [SongOld] = []
    var titles = Set<String>() // exists to check for duplicates
    
    func generateSetListData() -> [SongOld] {
        
        if (commonSongsList.count == 0) {
            
            var songs = [SongOld]()
            
            guard let liveSetsDataFilePath = Bundle.main.path(forResource: "setlist-data", ofType: "json"),
                  let liveSetsData = FileManager.default.contents(atPath: liveSetsDataFilePath) else { return [] }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: liveSetsData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                    
                    //json is a dictionary
                    if let setlists = json["setlists"] as? [Any] { //setlists is an array of 2327 values
                        
                        for show in setlists { //"show" is an ANY
                            
                            if show is Dictionary<AnyHashable, Any> {
                                
                                // so it has to be cast as dict to sort thru k-v pairs
                                guard let showDetailsDict = show as? [String: Any] else {
                                    print("showDetailsDict failed to cast")
                                    return [] }
                                
                                for (key, value) in showDetailsDict {
                                    
                                    if key == "sets" {
                                        
                                        guard let setDetailsDict = value as? [String: Any] else {
                                            print("setDetailsDict failed to cast")
                                            return []}
                                        
                                        for (key, value) in setDetailsDict {
                                            
                                            if (key == "set") {
                                                
                                                guard let setArray = value as? [Any] else { return [] }
                                                
                                                for detail in setArray { //everything next level is dictionary
                                                    
                                                    guard let detailsDict = detail as? [String: Any] else {
                                                        print("detailsDict failed to cast")
                                                        return [] }
                                                    
                                                    for (key, value) in detailsDict {
                                                        
                                                        if (key == "song") { // value of key "song" is an array of songs. Yes. It's a bad name
                                                            
                                                            guard let songArray = value as? [Any] else {
                                                                print("songArray failed to cast as an array")
                                                                return [] }
                                                            
                                                            for item in songArray { //inside songs array, song details are a dictionary
                                                                
                                                                guard let songDetails = item as? [String: Any] else {
                                                                    print("songDetails failed to cast as a dictionary")
                                                                    return [] }
                                                                
                                                                for (key, value) in songDetails {
                                                                    
                                                                    if (key == "name") {
                                                                        
                                                                        guard let songTitle = value as? String else {
                                                                            print("songTitle failed to cast as a string")
                                                                            return [] }
                                                                        
                                                                        if (songTitle != "") {
                                                                            
                                                                            // found song with valid text title
                                                                            if !titles.contains(songTitle) {
                                                                                
                                                                                // title is not in our array so add the song
                                                                                titles.insert(songTitle)
                                                                                
                                                                                let song = SongOld(name: songTitle, year: nil, timesPlayed: 1, favorite: false, details: nil)
                                                                                
                                                                                songs.append(song)
                                                                                
                                                                            } else {
                                                                                
                                                                                // title already exists in list
                                                                                //increment count
                                                                                
                                                                                if let index = songs.firstIndex(where: {$0.name == songTitle}) {
                                                                                    var Song = songs[index]
                                                                                    Song.timesPlayed += 1
                                                                                    songs[index] = Song
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                songs.sort(by:{$0.name < $1.name})
                commonSongsList = songs
                return commonSongsList;
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        return []
    }
    
    /* https://musicbrainz.org/doc/MusicBrainz_API may not be possible to get the song data easily. Maybe I'm missing something
     but it seems the ablum data doesn't even have song data*/
//    let kUrlConstant : String = "https://musicbrainz.org/ws/2/artist/6faa7ca7-0d99-4a5e-bfa6-1fd5037520c6?inc=releases&type=album&status=official&fmt=json"
    let kUrlConstant : String = "https://api.setlist.fm/1.0/artist/6faa7ca7-0d99-4a5e-bfa6-1fd5037520c6"// artistName/grateful-dead"
    
    var albumCollection : [Album] = []
    
    struct Album : Codable {
        
        var title : String?
        var date : String?
        var sortName : String?
        var artistName : String?
        var releases : [String]?
        
        enum CodingKeys: String, CodingKey {
            case title = "title"
            case date = "date"
            case sortName = "sort-name"
            case artistName = "name"
            case releases = "releases"
            
            //case additionalInfo

        }
        
        //        enum AdditionalInfoKeys: String, CodingKey {
        //            case title = "title"
        //            case releaseDate = "date"
        //        }
        //
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            //            print(values)
            
            //            artistName = try values.decode(String.self, forKey: .artistName) // releases is container[12]
            title = try values.decode(String.self, forKey: .title)
            date = try values.decode(String.self, forKey: .date)
            //            let dictionary: [String: Any] = try decoder.container([String : Any].self, forKey: .releases)
            
            //            releases = try values.decode(Array.self, forKey: .releases)
            
            //            let dictionary: [String: Any] = try values.decode([String: Any].self, forKey: .releases)
            
            //            sortName = try values.decode(String.self, forKey: .sortName)
            
            //            let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
            //
            //
            //            title = try additionalInfo.decode(String.self, forKey: .title)
            //            releaseDate = try additionalInfo.decode(String.self, forKey: .releaseDate)
        }
        
        public func encode(to encoder: Encoder) throws {}
    }
    
    func otherCreate() {
        
        let setlist_API_Key = "_RYJGzYOFgqCITzykUaPqaidvqCFkdl6RNa2"
        let mbid = "6faa7ca7-0d99-4a5e-bfa6-1fd5037520c6"
        let setlistURL = "https://api.setlist.fm/rest/1.0/search/setlists?artistMbid=\(mbid)"

        guard let url = URL(string: "\(setlistURL)") else {
            print("invalid url")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("\(setlist_API_Key)", forHTTPHeaderField: "x-api-key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }

            if let str = String(data: data, encoding: .utf8) {
                print(str)
            }
        }.resume()
    }
    
    func createObjectsFromData() {
        
        let url = URL(string: kUrlConstant)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data)
                
                // cast generic "json" into a dictionary
                guard let alljson = json as? [String : Any] else { return }
                
                // declare array to hold "releases" value from json
                var releasearray : [Any] = []
                
                // get to right key in dictionary and store its value
                for (key, value) in alljson {
                    if key == "releases" {
                        releasearray = (value as? [Any])!
                    }
                }
                
                // turn json array type object back into a Data
                let data = try JSONSerialization.data(withJSONObject: releasearray)
                
                // now data made from correct type will cycle through and decode all
                self.albumCollection = try JSONDecoder().decode([Album].self, from: data)
                
                for i in self.albumCollection {
                    print(i.title!)
                }
                
            } catch let parseError {
                print(" \n <~~~~~~~~~~~~~~~> \n", parseError)
            }
        }
        
        task.resume()
    }
    
    
}




//    func createObjectsFromData() {
//
    // keep this as basic example of working to decode ONE item
//        let url = URL(string: kUrlConstant)!
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//        guard let data = data, error == nil else {
//            print(error?.localizedDescription as Any)
//            return
//        }
//
//        do {
//            let alb = try JSONDecoder().decode(Album.self, from: data)
//            self.albumCollection.append(alb)
//
//        } catch let parseError {
//                print(" *** ", parseError)
//            }
//        }
//
//        task.resume()
//    }

