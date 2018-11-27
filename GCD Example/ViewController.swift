//
//  ViewController.swift
//  GCD Example
//
//  Created by SENTHILKUMAR on 27/11/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageUrl: String = "http://tineye.com/images/widgets/mona.jpg"

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GCD_ImageDownload()
        
        serial_Queue()
        
        
        concurrent_Queue()
    }
    
    
    
    //MARK: GCD
    func GCD_ImageDownload()  {
        
        let url = URL(string: imageUrl)
        
        DispatchQueue.global(qos:.userInitiated).async {
            
          // Start background thread so that image loading does not make app unresponsive
          let data = try? Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                // When from background thread, UI needs to be updated on main_queue
                self.imageView.image = UIImage(data: data!)
                
            }
            
        }
        
    }
    
    
    //MARK: Serial Queue
    func serial_Queue() {
        
        let serialQueue = DispatchQueue(label: "com.target.test" ,qos:.default)
        
        serialQueue.async {
            for i in 0...10 {
                print("Serial Queue with Async = \(i)")
            }
        }
        
        serialQueue.sync {
            
            for i in 20...30 {
                print("Serial Queue With sync = \(i)")
            }
        }
        
    }
    
    //MARK: Concurrent Queue
    func concurrent_Queue()  {
        
        let concurrentQueue = DispatchQueue(label:"com.trest.concurrent",qos:.default,attributes:.concurrent)
        
        concurrentQueue.async {
            for i in 0...10 {
                print("Concurrent Queue with Async = \(i)")
            }
        }
        
        concurrentQueue.sync {
            for i in 20...30 {
                print("Concurrent Queue With Sync = \(i)")
            }
        }
        
    }


}

