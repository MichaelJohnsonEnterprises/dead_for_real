//
//  ViewController.swift
//  dead for real
//
//  Created by Michael Johnson on 6/21/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func start_didTouchUpInside(_ sender: Any) {
        
//        DataCreator().createObjectsFromData()
        DataCreator().otherCreate()

        let songsTableVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SongsListViewController") as! SongsListViewController

        songsTableVC.title = "Grateful Dead songs"
        songsTableVC.songs = DataCreator().generateSetListData()

        self.navigationController?.pushViewController(songsTableVC, animated: true)
    }
}
