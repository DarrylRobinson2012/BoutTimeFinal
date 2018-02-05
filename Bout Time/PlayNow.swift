//
//  ViewController.swift
//  Bout Time
//
//  Created by Darryl Robinson  on 1/14/18.
//  Copyright © 2018 DrobEnterprises. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {

    //Mark: eventButtons
    @IBOutlet weak var event1: UILabel!
    @IBOutlet weak var event2: UILabel!
    @IBOutlet weak var event3: UILabel!
    @IBOutlet weak var event4: UILabel!
    // Mark: Arrow Buttons
    @IBOutlet weak var down1 : UIButton!
    @IBOutlet weak var up2 : UIButton!
    @IBOutlet weak var down2 : UIButton!
    @IBOutlet weak var up3 : UIButton!
    @IBOutlet weak var down3: UIButton!
    @IBOutlet weak var up4: UIButton!
    // Mark: Text Box
    @IBOutlet weak var text1: UITextView!
    @IBOutlet weak var text2: UITextView!
    @IBOutlet weak var text3: UITextView!
    @IBOutlet weak var text4: UITextView!
    // Mark: View
    @IBOutlet weak var view2: UIView!
    //Mark: Progress Button
    @IBOutlet weak var nextRound: UIButton!
    //Timer
    @IBOutlet weak var timerLabel: UILabel!
    //shakelabel
    @IBOutlet weak var shakeLabel: UIButton!
    
    var seconds = 60
    var timer = Timer()
    var quiz : eventQuiz
    var urlString = " "
    var isTimerRunning = false
    
    // Running timer
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    //Ubdating timer
    @objc func updateTimer() {
        seconds -= 1
        timerLabel.text = timeString(time: TimeInterval(seconds))
        if seconds < 0 {
            checkAnswer()
        }
    }
    
    //Timer Values
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%01i:%02i", minutes, seconds )
    }
 
    // Resets the timer
    func resetTimer() {
        seconds = 60
        runTimer()
    }
    
    //Grabs the plist and converts it to a format the code accepts it.
    required init?(coder aDecoder: NSCoder) {
        do {
            let array = try PlistConverter.array(fromFile: "atlEvents", ofType: "plist")
            let answerList = try inventoryUnarchiver.eventInventory(fromArray: array)
            quiz = eventQuiz(event: answerList)
        }catch let error {
            fatalError("\(error)")
        }
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quiz.nextQuestion()
        refreshDisplay()
        roundCorners()
        unlockButtons()
             }// Do any additional setup after loading the view, typically from a nib.
    
        // Round the corners on view 2
        func roundCorners() {
        view2.layer.cornerRadius = 5
        }
        
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
        //Shake getsure activated
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            checkAnswer()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.becomeFirstResponder()
        }

    /*
    HELP ME:
    This function checks my order of the events and if the order is correct it returns the picture assoicated. However this is the main problem with my app. I cannot get this to work correctly. For some reason it checks the intial values not the values after the user makes the switch.
 */
    @IBAction func checkAnswer(){
        if quiz.checkAnswer() {
            nextRound.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
        } else {
            nextRound.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
        }
            lockButtons()
    }
    
    /*   I disable because I had a really hard time with displaying the web content
     @IBAction func webSite(_ sender: Any) {
       
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "webView") as! WebViewController
            self.present(vc, animated: true, completion: nil)
            }*/
    
    // Allows users to switch events based on the arrows
    @IBAction func switchEvent2(_ sender: UIButton) {
        if sender == down1 {
             let temp = text1.text
            text1.text = text2.text
            text2.text = temp
        } else if sender == down2 {
            let temp = text2.text
            text2.text = text3.text
            text3.text = temp
        } else if sender == down3 {
            let temp = text3.text
            text3.text = text4.text
            text4.text = temp
        }else if sender == up2 {
            let temp = text2.text
            text2.text = text1.text
            text1.text = temp
        }else if sender == up3 {
            let temp = text3.text
            text3.text = text2.text
            text2.text = temp
        } else if sender == up4 {
            let temp = text4.text
            text4.text = text3.text
            text3.text = temp
            }
    }
    // Starts the next round
    @IBAction func nextRound(_ sender: Any) {
        if quiz.isOver {
            showEndQuiz()
        } else {
            quiz.nextQuestion()
            unlockButtons()
            refreshDisplay()
        }
    }
    //Opens the last view
    func showEndQuiz() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "endView") as! EndViewController
        self.present(vc, animated: true, completion: nil)
        }
    //Activates play again button
    @IBAction func playAgainPushed() {
        showStartQuiz()
        quiz.beginQuiz()
        unlockButtons()
        refreshDisplay()
    }
    //Starts the quiz
    func showStartQuiz() {
        view2.isHidden = false
        nextRound.isHidden = false
        timerLabel.isHidden = false
        shakeLabel.isHidden = false
    }
    
    //Locks buttons
    func lockButtons() {
        event1.isEnabled = false
        event2.isEnabled = false
        event3.isEnabled = false
        event4.isEnabled = false
        down1.isEnabled = false
        up2.isEnabled = false
        down2.isEnabled = false
        up3.isEnabled = false
        down3.isEnabled = false
        up4.isEnabled = false
        nextRound.isHidden = false
       timer.invalidate()
        timerLabel.isHidden = true
    }
    
    //Activates buttons
    func unlockButtons() {
        down1.isEnabled = true
        up2.isEnabled = true
        down2.isEnabled = true
        up3.isEnabled = true
        down3.isEnabled = true
        up4.isEnabled = true
        nextRound.isHidden = true
        resetTimer()
        timerLabel.isHidden = false
        timerLabel.text = "1:00"
     }
    
    //Refreshes the textboxes with new events
    func refreshDisplay() {
        text1.text = quiz.round.event1.event
        text2.text = quiz.round.event2.event
        text3.text = quiz.round.event3.event
        text4.text = quiz.round.event4.event
    }
   
}
