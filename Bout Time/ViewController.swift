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
    
    //endView
    
    @IBOutlet weak var yourScore: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    
    // Mark: Text Box
    
    @IBOutlet weak var text1: UITextView!
    @IBOutlet weak var text2: UITextView!
    @IBOutlet weak var text3: UITextView!
    @IBOutlet weak var text4: UITextView!

    
    // Mark: Views
   
    @IBOutlet var endView: UIView!
    
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
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1
        timerLabel.text = timeString(time: TimeInterval(seconds))
        if seconds < 0 {
            checkAnswer()
        }
    
    }
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%01i:%02i", minutes, seconds )
    }
    func prep(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" {
            let vc = segue.destination as! WebViewController
            vc.urlString = urlString
            
        }
    }
    func resetTimer() {
        seconds = 60
        runTimer()
    }
    
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
    }
        // Do any additional setup after loading the view, typically from a nib.
        
        func roundCorners() {
        view2.layer.cornerRadius = 5
        
        }
        
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
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


    
    
    
    @IBAction func checkAnswer(){
        if quiz.checkAnswer() {
            nextRound.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
        } else {
            nextRound.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
        }
            lockButtons()
    }
    

    @IBAction func switchEvent(_ sender: UIButton) {
        
        var tempAnswer : eventDetails
        
        switch sender.tag {
        
        case 1:
            tempAnswer = quiz.round.event2
            quiz.round.event2 = quiz.round.event1
            quiz.round.event1 = tempAnswer
        case 2:
            tempAnswer = quiz.round.event3
            quiz.round.event3 = quiz.round.event2
            quiz.round.event2 = tempAnswer
        case 3:
            tempAnswer = quiz.round.event4
            quiz.round.event4 = quiz.round.event3
            quiz.round.event3 = tempAnswer
            default:
            break
        }
        
        refreshDisplay()
    }
     
    
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
    
    @IBAction func nextRound(_ sender: Any) {
        if quiz.isOver {
            showEndQuiz()
        } else {
            quiz.nextQuestion()
            unlockButtons()
            refreshDisplay()
        }
    }
    
    
     func showEndQuiz() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "endView") as! EndViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    // edit me
   /* func showEndQuiz() {
       view2.isHidden = true
        
        yourScore.isHidden = false
        score.isHidden = false
        playAgain.isHidden = false
        score.text = "\(quiz.score)/6"
        }
    */
    
    @IBAction func playAgainPushed() {
        showStartQuiz()
        quiz.beginQuiz()
        unlockButtons()
        refreshDisplay()
    }
    
    func showStartQuiz() {
        view2.isHidden = false
        nextRound.isHidden = false
        timerLabel.isHidden = false
        shakeLabel.isHidden = false
    }
    
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
        //linksEnabled(enabled: true)
       // nextRoundbutton.isHidden = false
        timer.invalidate()
        timerLabel.isHidden = true
      //  learnshakeLabel.text = "Text events to learn more"
    }
    
    func unlockButtons() {
        
        down1.isEnabled = true
        up2.isEnabled = true
        down2.isEnabled = true
        up3.isEnabled = true
        down3.isEnabled = true
        up4.isEnabled = true
       // linksEnabled(enabled: false)
        nextRound.isHidden = true
        resetTimer()
        timerLabel.isHidden = false
        timerLabel.text = "1:00"
      //  learnshakeLabel.text = "Shake to submit answer"
    }
    
    func refreshDisplay() {
        text1.text = quiz.round.event1.event
        text2.text = quiz.round.event2.event
        text3.text = quiz.round.event3.event
        text4.text = quiz.round.event4.event
    }

}
