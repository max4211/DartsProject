//
//  ScoreGame.swift
//  dartsBeta1
//
//  Created by Max Smith on 4/9/19.
//  Copyright © 2019 TBE Productions. All rights reserved.
//

import UIKit

class ScoreGame: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Names of players to keep track of
    // var names = ["Jake", "Max", "Noah"]
    var names = [String]()
    var scores = [Int]()
    var roundScore = 0 // Update for each sum of darts
    var guy = -1 // Modulate this to keep track of which players score we are editing
    var winner = String()
    
    // Table to display player score and data
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "nameScore")
        cell.textLabel?.text = "\(names[indexPath.row]) \t \t \t \t \t \t \t \t \t \(scores[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Code to do when a row is selected
        
    }
    
    @IBOutlet weak var dart1: UITextField!
    @IBOutlet weak var dart2: UITextField!
    @IBOutlet weak var dart3: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTextFields()
        configureTapGesture()
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ScoreGame.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        print("Handle Tap was Called")
        view.endEditing(true)
    }
    
    private func configureTextFields() {
        dart1.delegate = self
        dart2.delegate = self
        dart3.delegate = self
    }
    
    // Ensure text is a number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowCharacters = "+1234567890"
        // Restrict this to 0-60
        let allowCharacterSet = CharacterSet(charactersIn: allowCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        return allowCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    // Update global scores when enter is tapped
    // Change to the next player in the system
    @IBAction func enterTap(_ sender: Any) {
        view.endEditing(true)
        roundScore = 0 // Reset roundscore each time
        guy = guy + 1 // on first press this becomes player one
        if let firstDart = Int(dart1.text!) {
            roundScore += firstDart
        }
        if let secondDart = Int(dart2.text!) {
            roundScore += secondDart
        }
        if let thirdDart = Int(dart3.text!) {
            roundScore += thirdDart
        }
        print("\(roundScore)")
        scoreReset()
        scoreUpdate()
    }
    
    private func scoreReset() {
        dart1.text! = ""
        dart2.text! = ""
        dart3.text! = ""
    }
    
    // Update the score based on current round score
    private func scoreUpdate() {
        // Reset guy when it exceeds player count
        if guy == names.count {
            guy = 0
        }
        let scoreTemp = scores[guy] - roundScore
        
        if scoreTemp > 0 {
            // Update score
            scores[guy] = scoreTemp
        } else if scoreTemp < 0 {
            // continue accepting scores, don't change any players
        } else {
            endGame()
        }
        
        // Update the table
        self.tableView.reloadData()
    }
    
    private func endGame() {
        // Add endgame sequence
        // Congratulations with possible stats
        winner = names[guy]
        performSegue(withIdentifier: "gameOver", sender: self)
    }
    
    // Add segues to prepare for endgame
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! GameOver
        vc.victor = winner
    }

}

extension ScoreGame: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
