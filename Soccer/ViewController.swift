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
    
    
    func createArrays(numberOfGames: Int, numberOfTeams: Int) {
        let minimumNumberOfGames = Int(numberOfGames / numberOfTeams)
        let remainder = numberOfGames % numberOfTeams
        
        for _ in 0..<minimumNumberOfGames {
            for team in 1...numberOfTeams {
                hostTeams.append(team)
            }
        }
        
        if remainder > 0 {
            for index in 1...remainder {
                hostTeams.append(index)
            }
        }
        
        guestTeams = hostTeams.shift(withDistance: 1)
        var tempArray = Array(guestTeams.prefix(upTo: numberOfTeams))
        guestTeams = hostTeams.shift(withDistance: 2)
        tempArray.append(contentsOf: Array(guestTeams.suffix(from: numberOfTeams)))
        guestTeams = tempArray
    }
    
    func pairTeams() {
        
        print(hostTeams)
        print(guestTeams)
        print("")
        
    }
}



extension Array {
    
    /**
     Returns a new array with the first elements up to specified distance being shifted to the end of the collection. If the distance is negative, returns a new array with the last elements up to the specified absolute distance being shifted to the beginning of the collection.
     
     If the absolute distance exceeds the number of elements in the array, the elements are not shifted.
     */
    func shift(withDistance distance: Int = 1) -> Array<Element> {
        let offsetIndex = distance >= 0 ?
            self.index(startIndex, offsetBy: distance, limitedBy: endIndex) :
            self.index(endIndex, offsetBy: distance, limitedBy: startIndex)
        
        guard let index = offsetIndex else { return self }
        return Array(self[index ..< endIndex] + self[startIndex ..< index])
    }
    
    /**
     Shifts the first elements up to specified distance to the end of the array. If the distance is negative, shifts the last elements up to the specified absolute distance to the beginning of the array.
     
     If the absolute distance exceeds the number of elements in the array, the elements are not shifted.
     */
    mutating func shiftInPlace(withDistance distance: Int = 1) {
        self = shift(withDistance: distance)
    }
    
}
