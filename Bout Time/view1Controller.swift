//
//  View1Controller.swift
//  Bout Time
//
//  Created by Darryl Robinson  on 1/23/18.
//  Copyright © 2018 DrobEnterprises. All rights reserved.
//

import UIKit

class View1Controller: UIViewController {
    // Labels
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
    // Go to view2
    @IBAction func Dismiss(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "view2") as! ViewController
        self.present(vc, animated: true, completion: nil)
    }
   
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
}
 */

