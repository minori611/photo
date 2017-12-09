//
//  sharePhotoViewController.swift
//  photo
//
//  Created by Minori_n on 2017/11/26.
//  Copyright © 2017年 那須美律. All rights reserved.
//

import UIKit
import Accounts

class sharePhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.image
        // Do any additional setup after loading the view.
    }
    
    @IBAction func postTwitter() {
        let shareImage = imageView.image!
        
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
