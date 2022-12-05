//
//  SongsListViewController.swift
//  dead songs
//
//  Created by Michael Johnson on 8/15/22.
//

import Foundation
import UIKit

class SongsListViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var songsListTableView: UITableView!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var frequencySwitch : UISwitch!
    
    @IBOutlet weak var ascendingLabel: UILabel!
    @IBOutlet weak var ascendingSwitch : UISwitch!
    
    let refreshControl = UIRefreshControl()

    let cellReuseIdentifier = "SongCell"
    public var songs : [LiveSong] = []

    override func viewDidLoad() {

        SetlistGenerator().generateSetlistData()
        
        self.title = "Grateful Dead songs"
        
        self.songsListTableView.delegate = self
        self.songsListTableView.dataSource = self
        self.songsListTableView.register(SongCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        self.frequencySwitch.setOn(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = songsListTableView.indexPathForSelectedRow {
            songsListTableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func refresh(sender:AnyObject) {
        
    }
    
    @IBAction func sortByFrequencyToggled(_ sender: Any) {
        
        if (self.frequencySwitch.isOn) {
            self.songs.sort(by:{$0.timesPlayed > $1.timesPlayed})
        
        } else {
            self.songs.sort(by:{$0.name < $1.name})
        }
        
        self.songsListTableView.reloadData()
    }
    
    @IBAction func sortAscendingToggled(_ sender: Any) {
 
        self.songs.reverse()
        self.songsListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? SongCell {
            
            cell.textLabel?.text = songs[indexPath.row].name
            cell.detailTextLabel?.text = String(songs[indexPath.row].timesPlayed)
            
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell : SongCell = tableView.cellForRow(at: indexPath) as! SongCell

        let songDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SongDetailViewController") as! SongDetailViewController
        
        let _ = songDetailVC.view
        
        songDetailVC.setSongTitleLabelText(text: cell.textLabel?.text ?? "y no title")
        songDetailVC.setSeparatorColor(color: cell.backgroundColor ?? UIColor.black)
        
        self.navigationController?.pushViewController(songDetailVC, animated: true)
    }

}
