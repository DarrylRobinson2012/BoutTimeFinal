//
//  WebViewController.swift
//  Bout Time
//
//  Created by Darryl Robinson  on 1/23/18.
//  Copyright © 2018 DrobEnterprises. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*HELP ME:
         This is supposed to display webcontent once the website() func is called but for some reason once is called there is only a blank screen
 */
        let url = URL(string: "http://media.atlantafalcons.com/assets/History.pdf")
        let request = URLRequest(url: url!)
        webView.load(request)
    }

        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //This is supposed to close the webview and bring me back to the view to but it seems as if the button does not work.
    @IBAction func closeView(_ sender: Any) {
         dismiss(animated: true, completion: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "view2") as! ViewController
        self.present(vc, animated: true, completion: nil)
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
