//
//  StructProvider .swift
//  Bout Time
//
//  Created by Darryl Robinson  on 1/14/18.
//  Copyright © 2018 DrobEnterprises. All rights reserved.
//

import Foundation
import UIKit

// Rules for events
protocol atlEvent {
    var year: Int {get}
    var event: String {get}
   }
// Actual Events
struct eventDetails : atlEvent {
    var year: Int
    var event: String
    init(year: Int, event: String){
        self.year = year
        self.event = event
    }
}
//Errora that could happen while pulling the data
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
            if let year = value["year"] as? Int, let event = value["event"] as? String {
                let event = eventDetails(year: year, event: event )
                inventory.append(event)
            }
        }
        return inventory
    }
}
//Rules for each round
protocol quizRound {
    var event1: eventDetails { get set  }
    var event2: eventDetails { get set }
    var event3: eventDetails { get set }
    var event4: eventDetails { get set  }
    var text1: Int {get set}
    var text2: Int {get set}
    var text3: Int {get set}
    var text4: Int {get set}
    }

//The actual round
class EventRound: quizRound {
    var event1: eventDetails
    var event2: eventDetails
    var event3: eventDetails
    var event4: eventDetails
    
    var text1: Int
    var text2: Int
    var text3: Int
    var text4: Int
//Checks the answer. I think this is where the problem stems.
    func checkAnswer() -> Bool {
        if( text1 < text2 && text2 < text3 && text3 < text4) {
            return true
            }
        return false
    }
    init (event1: eventDetails, event2: eventDetails, event3: eventDetails, event4: eventDetails, text1: Int, text2: Int, text3: Int, text4: Int) {
        self.event1 = event1
        self.event2 = event2
        self.event3 = event3
        self.event4 = event4
        self.text1 = text1
        self.text2 = text2
        self.text3 = text3
        self.text4 = text4
        }
}
//rules for the quiz
protocol quiz {
    var event : [eventDetails] { get }
    var round :  EventRound { get set }
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
//The actual quiz
class eventQuiz: quiz {
    var event: [eventDetails]
    var round: EventRound
    var fullEvent: [eventDetails]
    var score = 0
    var count = 0
    var isOver =  false
    //begins the quiz
    func beginQuiz() {
        isOver = false
        score = 0
        count = 0
        event = fullEvent
        nextQuestion()
    }
    //shuffles the events
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
    //Ends the quiz
    func endQuiz() {
        isOver = true
    }
    //Loads the next question
    func nextQuestion() {
        count += 1
        event = shuffleTheEvents(array: event)
        round = EventRound(event1: event[0], event2: event[1], event3: event[2], event4: event[3], text1: event[0].year, text2: event[1].year, text3: event[2].year, text4: event[3].year)
        event.remove(at: 3)
        event.remove(at: 2)
        event.remove(at: 1)
        event.remove(at: 0)
        print(event)
        
        if count >= 6 {
            endQuiz()
        }
    }
    //Or the problem could be coming from here
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
        self.round = EventRound(event1: event[0], event2: event[1], event3: event[2], event4: event[3], text1: event[0].year, text2: event[1].year, text3: event[2].year, text4: event[3].year)
    }
    }



    

        

    
    


    
    


