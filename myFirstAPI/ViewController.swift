//
//  ViewController.swift
//  myFirstAPI
//
//  Created by Kevin Bluer on 9/5/14.
//  Copyright (c) 2014 Bluer Inc. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var helloMessage: UILabel!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Change the background color
        let rect : CGRect = CGRectMake(0,0,320,100)
        var vista : UIView = UIView(frame: CGRectMake(0, 0, 320, 600))
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.frame = vista.bounds
        
        let cor1 = UIColor(hex:0x73B1EB).CGColor
        let cor2 = UIColor(hex:0x4B85FE).CGColor

        let arrayColors: Array <AnyObject> = [cor1, cor2]
        
        //
        
        gradient.colors = arrayColors
        view.layer.insertSublayer(gradient, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loadData(sender: AnyObject) {
        
        // create the empty params dictionary
        var params = [:] as Dictionary
        
        // create the request object and set the url
        var request = NSMutableURLRequest(URL: NSURL(string: "http://api.bluer.com/hello/kevin"))
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        request.HTTPMethod = "POST"
        
        // add all the parameters
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // setup the async task
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            let json = JSONValue(data)
            
            self.helloMessage.text = "Hello " + json["name"].string!
        })
        
        // start the task
        task.resume()
        
    }

}

