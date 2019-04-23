//
//  SelectGame.swift
//  dartsBeta1
//
//  Created by student on 4/8/19.
//  Copyright © 2019 TBE Productions. All rights reserved.
//

import UIKit

class SelectGame: UIViewController {

    var pointTotal = Int()
    
    @IBAction func game301(_ sender: Any) {
        performSegue(withIdentifier: "game301", sender: self)
    }
    
    @IBAction func game501(_ sender: Any) {
        performSegue(withIdentifier: "game501", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //performSegue(withIdentifier: "gameBegin", sender: self)

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    var vc = segue.destination as! AddPlayers
    if segue.identifier == "game301" {
       vc.pointTotal = 301
    } else {
        vc.pointTotal = 501
    }
}

}
