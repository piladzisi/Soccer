//
//  ViewController.swift
//  Soccer
//
//  Created by Anna Sibirtseva on 14/01/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberOfGamesTextField: UITextField!
    @IBOutlet weak var numberOfTeamsTextField: UITextField!

    var numberOfGames: Int = 0
    var numberOfTeams: Int = 0
    
    var hostTeams = [Int]()
    var guestTeams = [Int]()
    var games = [Int : Int]()
    
    
    @IBAction func didTapLetsPlay() {
        guard
            let games = numberOfGamesTextField.text,
            let teams = numberOfTeamsTextField.text
        else { return }
        
        numberOfGames = Int(games)!
        numberOfTeams = Int(teams)!
        
        hostTeams.removeAll()
        guestTeams.removeAll()
        
        createArrays(numberOfGames: numberOfGames, numberOfTeams: numberOfTeams)
        pairTeams()
    }
    
    //if number of games = 9, and there are 5 teams, each team can play at least once, and the remaining 4 games will be played randomly.
    func createArrays(numberOfGames: Int, numberOfTeams: Int) {
        
        let minimumNumberOfGames = Int(numberOfGames / numberOfTeams)
        let remainder = numberOfGames % numberOfTeams
        
        for _ in 0..<minimumNumberOfGames {
            for team in 1...numberOfTeams {
                hostTeams.append(team)
            }
        }
        
        for _ in 0..<remainder {
            let random = Int.random(in: 1...numberOfTeams)
            hostTeams.append(random)
        }
        
        guestTeams = hostTeams.shuffled()
    }
    
    func pairTeams() {
        hostTeams.shuffle()
        for index in 0..<hostTeams.count {
            if hostTeams[index] == guestTeams[index] {
                hostTeams.shuffle()
            }
        }
        
        
        print(hostTeams)
        print(guestTeams)
        print("")
        
    }
    
    
}

