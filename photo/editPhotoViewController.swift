//
//  editPhotoViewController.swift
//  photo
//
//  Created by Minori_n on 2017/09/09.
//  Copyright © 2017年 那須美律. All rights reserved.
//

import UIKit
import Social

class editPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
   
    var originalImage: UIImage!
    var filter: CIFilter!
    var brightness = 1.0
    var contrast = 1.0
    let slider = UISlider(frame: CGRect(x:0, y:0, width:300, height:30))
    private var twitterButton: UIButton!
    private var facebookButton: UIButton!
    private var instagramButton: UIButton!
    private var button: UIButton!
    var composeView: SLComposeViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openAlbum()
    }
    
    func addSlider() {
        slider.layer.position = CGPoint(x:self.view.frame.midX, y:600)
        slider.layer.cornerRadius = 10.0
        slider.layer.shadowOpacity = 0.5
        slider.layer.masksToBounds = false
        slider.tintColor = UIColor.gray
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.setValue(0.0, animated: true)
        slider.addTarget(self, action: #selector(self.changeBrightness(sender:)), for: .valueChanged)
        self.view.addSubview(slider)
    }
    
    func addButton() {
        button = UIButton()
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.frame.width/2 - bWidth/2
        let posY: CGFloat = self.view.frame.height/2 - bHeight/2
        button.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(self.removeSlider(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func openAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo Info: [String : Any]) {
        imageView.image = Info[UIImagePickerControllerEditedImage] as? UIImage
        
        originalImage = imageView.image
        
        dismiss(animated: true, completion: nil)
    }
    
//スライダーの削除
    func removeSlider(sender: UIButton) {
        slider.removeFromSuperview()
        button.removeFromSuperview()
        print("here")
    }
    
    @IBAction func brightnessButton() {
        addSlider()
        addButton()
        slider.addTarget(self, action: #selector(self.changeBrightness(sender:)), for: .valueChanged)
        self.view.addSubview(slider)
        
    }
    
    func changeBrightness(sender: UISlider) {
        brightness = Double(sender.value)
        changeFilter()
        
    }
    
    @IBAction func contrastButton() {
        addSlider()
        addButton()
        slider.addTarget(self, action: #selector(self.changeContrast(sender:)), for: .valueChanged)
        self.view.addSubview(slider)
    }
    
    func changeContrast(sender: UISlider) {
        changeFilter()
    }
    
    
    
    func changeFilter() {
        let filterImage: CIImage = CIImage(image: originalImage)!
        
        //filter
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        //brightness
        filter.setValue(brightness, forKey: "inputBrightness")
        
        //contrast
        filter.setValue(contrast, forKey: "inputContrast")

        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        imageView.image = UIImage(cgImage: cgImage!)
    }
    
    @IBAction func sharePhoto(){
        addShareButtons()
    }
    
    func addShareButtons() {
        //twitter
        twitterButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        twitterButton.setTitle("Twitter", for: UIControlState.normal)
        twitterButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        twitterButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height/2)
        twitterButton.addTarget(self, action: #selector(self.postonTwitter(sender:)), for: .touchUpInside)
        
        self.view.addSubview(twitterButton)
        
        //facebook
        facebookButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        facebookButton.setTitle("Facebook", for: UIControlState.normal)
        facebookButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        facebookButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height/2)
        facebookButton.addTarget(self, action: #selector(self.postonFacebook(sender:)), for: .touchUpInside)
        
        self.view.addSubview(facebookButton)
        
        //instagram
        instagramButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        instagramButton.setTitle("Instagram", for: UIControlState.normal)
        instagramButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        instagramButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height/2)
        instagramButton.addTarget(self, action: #selector(self.postonInstagram(sender:)), for: .touchUpInside)
        
        self.view.addSubview(facebookButton)
    }
    
    func postonTwitter(sender: UIButton) {
        composeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        composeView.add(imageView.image!)
    }
    
    func postonFacebook(sender: UIButton) {
        composeView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        composeView.add(imageView.image!)
    }
    
    func postonInstagram(sender: UIButton) {
    }
    
    @IBAction func savePhoto() {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
        self.performSegue(withIdentifier: "photoConfirm", sender: self)
    }

    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoConfirm" {
            let PhotoConfirm: PhotoConfirm = segue.destination as! PhotoConfirm
        
            imageView.image = self.originalImage!
        }
 }*/
 
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
