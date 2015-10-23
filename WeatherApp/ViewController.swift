//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Cheng on 10/22/15.
//  Copyright © 2015 davidcheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    
    @IBOutlet weak var resultLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    @IBAction func findWeather(sender: AnyObject) {
        let URL = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text! + "/forecasts/latest")!
        //        let URL = NSURL(string: "http://stackoverflow.com")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(URL) {
            (data, response, error) -> Void in
            if let urlContent = data {
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let websiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                if websiteArray!.count > 0 {
                    
                    let weatherArray = websiteArray![1].componentsSeparatedByString("</span>")
                    //                    print(weatherArray[0])
                    if weatherArray.count > 0 {
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º");
                        dispatch_async(dispatch_get_main_queue(), {() -> Void in
                            self.resultLabel.text = weatherSummary
                        })
                        
                        
                        
                    }
                }
                //                print(webContent)
                
            }
        }
        task.resume()
    }
}

