//
//  EndViewController.swift
//  Bout Time
//
//  Created by Darryl Robinson  on 1/28/18.
//  Copyright © 2018 DrobEnterprises. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    @IBOutlet var endView: UIView!
    @IBOutlet weak var yourScore: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    
    
    @IBAction func launchPlayAgain(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "view1") as! View1Controller
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
