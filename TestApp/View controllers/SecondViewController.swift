//
//  SecondViewController.swift
//  TestApp
//
//  Created by Vanita on 1/25/18.
//  Copyright © 2018 Tixdo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var lastRotation: CGFloat = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotatedView(_:)))
        self.view.addGestureRecognizer(rotate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func rotatedView(_ sender: UIRotationGestureRecognizer) {
        print("rotation gesture is detected")
        var originalRotation = CGFloat()
        if sender.state == .began {
            sender.rotation = lastRotation
            originalRotation = sender.rotation
        } else if sender.state == .changed {
            
            let newRotation = sender.rotation + originalRotation
            imageView?.transform = CGAffineTransform(rotationAngle: newRotation)
            print("frame:", imageView.frame)
            print("bounds: ", imageView.bounds)
        } else if sender.state == .ended {
            // Save the last rotation
            lastRotation = sender.rotation
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

}
