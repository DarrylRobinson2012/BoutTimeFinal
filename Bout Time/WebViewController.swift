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
    
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let unwrappedUrlString = urlString {
            let urlRequest = URLRequest(url: URL(string: unwrappedUrlString)!)
            webView.load(urlRequest)
            
            print(webView.isLoading)
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeView(_ sender: ANY) {
        dismss(animated: true, dismiss(animated: true, completion: nil))
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
