//
//  View1Controller.swift
//  Bout Time
//
//  Created by Darryl Robinson  on 1/23/18.
//  Copyright © 2018 DrobEnterprises. All rights reserved.
//

import UIKit

class View1Controller: UIViewController {

    @IBOutlet weak var boutTimeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func transition(Sender: UIButton!) {
        let secondViewController:ViewController = ViewController()
        
        self.View1Controller(ViewController, animated: true, completion: nil)
        
    }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


