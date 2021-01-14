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
    var teams = [Int]()
    
    @IBAction func didTapLetsPlay() {
        guard
            let games = numberOfGamesTextField.text,
            let teams = numberOfTeamsTextField.text
        else { return }
        
       numberOfGames = Int(games)!
       numberOfTeams = Int(teams)!
        
        self.teams.removeAll()

        createTeams(numberOfTeams: numberOfTeams)
        print(self.teams)
        matchmaking(teams: self.teams)
    }
    
    func createTeams(numberOfTeams: Int) {
        for team in 1...numberOfTeams {
            teams.append(team)
        }
    }
    
    
    func matchmaking(teams teamsLeftToPlay: [Int], teamsPlayed: [Int: [Int]] = [:]) {
        
        guard numberOfGames > 0 else {
            print("all games already played!")
            return
        }
        
        var teamsPlayed = teamsPlayed
        
        
        for team in teamsLeftToPlay.shuffled() {
            if let guest = teamsLeftToPlay.randomElement(),
               !(teamsPlayed[team]?.contains(guest) ?? false),
                team != guest,
                numberOfGames > 0 {
                print("\(team) vs \(guest)")
               
                numberOfGames -= 1
                print("Number Of Games: \(numberOfGames)")
                if let teamMatches = teamsPlayed[team], teamMatches.count > 0 {
                    teamsPlayed[team]?.append(guest)
                } else {
                    teamsPlayed[team] = [guest]
                }
            }
        }
        
    matchmaking(teams: teamsLeftToPlay, teamsPlayed: teamsPlayed)
        
    }
    
}
