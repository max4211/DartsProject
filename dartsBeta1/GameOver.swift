//
//  GameOver.swift
//  dartsBeta1
//
//  Created by student on 4/9/19.
//  Copyright © 2019 TBE Productions. All rights reserved.
//

import UIKit

class GameOver: UIViewController {

    @IBOutlet weak var winnerName: UILabel!
    
    var victor = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.winnerName.text = victor
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func playAgain(_ sender: Any) {
        performSegue(withIdentifier: "playAgain", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! SelectGame
    }
    
    
    
}
