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
        
        let songsTableVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SongsListViewController") as! SongsListViewController
        self.navigationController?.pushViewController(songsTableVC, animated: true)
    }
}
