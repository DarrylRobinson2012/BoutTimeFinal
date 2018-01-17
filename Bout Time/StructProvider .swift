//
//  StructProvider .swift
//  Bout Time
//
//  Created by Darryl Robinson  on 1/14/18.
//  Copyright © 2018 DrobEnterprises. All rights reserved.
//

import Foundation
import UIKit

enum Position : Int {
    case one
    case two
    case three
    case four
}





protocol atlEvent {
    var year: Int {get}
    var event: String {get}
    
}

struct eventDetails : atlEvent {
    var year: Int
    var event: String
}


enum InvenoryError: Error {
    case InvalidResource
    case ConversionError
    case invalidSelection
}

//converts the plist into an array

class PlistConverter {
    static func array(fromFile name: String, ofType type: String) throws -> [AnyObject] {
        guard let path = Bundle.main.path(forResource: name, ofType: type ) else {
            throw InvenoryError.InvalidResource
            }
        guard let array = NSArray(contentsOfFile: path) as? [AnyObject] else {
            throw InvenoryError.ConversionError
        }
        return array
    
}
}
    // converts the array to a format that the array into a readable format
    
    class inventoryUnarchiver {
        static func eventInventory(fromArray array: [AnyObject]) throws -> [eventDetails] {
            
            var inventory: [eventDetails] = []
            for value in array {
                if let eventArray = value as? [String: Any], let year = eventArray["year"] as? Int, let event = eventArray["event"] as? String {
                    let event = eventDetails(year: year, event: event)
                
                    inventory.append(event)
                }
            }
            return inventory
        }
    
}



protocol quizRound {
    var event1: eventDetails { get }
    var event2: eventDetails { get }
    var event3: eventDetails { get }
    var event4: eventDetails { get }
    
    func  checkAnswer() -> Bool
    }


class EventRound: quizRound {
    var event1: eventDetails
    var event2: eventDetails
    var event3: eventDetails
    var event4: eventDetails
    
    func checkAnswer() -> Bool {
        if( event1.year < event2.year && event2.year < event3.year && event3.year < event4.year) {
            return true
            
        } else {
            return false
            }
    }
        init (event1: eventDetails, event2: eventDetails, event3: eventDetails, event4: eventDetails) {
        self.event1 = event1
        self.event2 = event2
        self.event3 = event3
        self.event4 = event4
    
    }
}

protocol quiz {
    var event : [eventDetails] { get }
    var round :  EventRound { get }
    var fullEvent : [eventDetails] { get }
    var score : Int { get set}
    var count : Int { get set}
    var isOver : Bool { get set}

    func beginQuiz()
    func shuffleTheEvents(array: [eventDetails]) -> [eventDetails]
    func endQuiz()
    func nextQuestion()
    func checkAnswer() -> Bool
}

class eventQuiz: quiz {

    var event: [eventDetails]
    var round: EventRound
    var fullEvent: [eventDetails]
    var score = 0
    var count = 0
    var isOver =  false
    
    func beginQuiz() {
        isOver = false
        score = 0
        count = 0
        event = fullEvent
        nextQuestion()
    }
    
    func shuffleTheEvents(array: [eventDetails]) -> [eventDetails] {
        var tempArray = array
        var shuffled: [eventDetails] = []
            for _  in 0..<tempArray.count
            {
                let random  = Int(arc4random_uniform(UInt32(tempArray.count)))
                shuffled.append(tempArray[random])
                tempArray.remove(at: random)
    }
        return shuffled
    }
    
    func endQuiz() {
        isOver = true
    }
    func nextQuestion() {
        count += 1
        
        event = shuffleTheEvents(array: event)
        round = EventRound(event1: event[0], event2: event[1], event3: event[2], event4: event[3])
        event.remove(at: 3)
        event.remove(at: 2)
        event.remove(at: 1)
        event.remove(at: 0)
        print(event)
        
        if count >= 6 {
            endQuiz()
        }
    }
    
    func checkAnswer() -> Bool {
        let result = round.checkAnswer()
        if result {
            score += 1
        }
        return round.checkAnswer()
        }
    
    init(event: [eventDetails]) {
        self.event = event
        self.fullEvent = event
        self.round = EventRound(event1: event[0], event2: event[1], event3: event[2], event4: event[3])
    }
    
}
    
    



    

        

    
    


    
    


