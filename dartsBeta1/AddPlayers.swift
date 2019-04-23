//
//  AddPlayers.swift
//  dartsBeta1
//
//  Created by Max Smith on 4/8/19.
//  Copyright © 2019 TBE Productions. All rights reserved.
//

import UIKit

class AddPlayers: UIViewController {

    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var playerView: UITextView!
    
    var pointTotal = Int()
    var count = 0 // Keep track of total players
    var playersEntered = [String]() // Keep track of players entered
    
    override func viewDidLoad() {
        super.viewDidLoad()
    playerName.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Add players to a table when this is pressed
    @IBAction func addPlayer(_ sender: Any) {
        playersEntered.append(playerName.text!)
        count = count + 1
        playerView.text = arrayToEnumerate(names: playersEntered)
        playerName.text = nil
    }
    
    // Input the players entered array, output an enumerated list
    func arrayToEnumerate (names: [String]) -> String {
        var playerListUpdate = ""
        var counter = 1
        
        for i in names {
            playerListUpdate += "\(counter)) \(i) \n"
            counter += 1
        }
        return playerListUpdate
    }
    
    // When you touch outside pad keyboard is dismissed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerName.resignFirstResponder()
    }

    // When player starts a game
    @IBAction func startGame(_ sender: Any) {
        // let players = playersEntered
        performSegue(withIdentifier: "gameBegin", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! ScoreGame
        vc.names = playersEntered
        // Edit this for different types of segues
        vc.scores = Array(repeating: pointTotal, count: playersEntered.count)
    }
}


extension AddPlayers : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
