//
//  WebViewController.swift
//  Piita
//
//  Created by 中嶋裕也 on 2018/11/21.
//  Copyright © 2018 中嶋裕也. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet var webview: WKWebView!
    
    var myURL:URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let URLrequest = URLRequest(url: myURL!)
        webview.load(URLrequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
