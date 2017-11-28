//
//  editPhotoViewController.swift
//  photo
//
//  Created by Minori_n on 2017/09/09.
//  Copyright © 2017年 那須美律. All rights reserved.
//

import UIKit

class editPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
   
    var originalImage: UIImage!
    var filter: CIFilter!
    var brightness = 0.0
    var contrast = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openAlbum()
    }
    
    func addSlider() {
        let slider = UISlider(frame: CGRect(x:0, y:0, width:300, height:30))
        slider.layer.position = CGPoint(x:self.view.frame.midX, y:600)
        slider.layer.cornerRadius = 10.0
        slider.layer.shadowOpacity = 0.5
        slider.layer.masksToBounds = false
        slider.tintColor = UIColor.black
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.setValue(0.0, animated: true)
        slider.addTarget(self, action: #selector(self.changeBrightness(sender:)), for: .valueChanged)
        self.view.addSubview(slider)
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
    
    @IBAction func brightnessButton() {
        addSlider()
    }
    
    func changeBrightness(sender: UISlider) {
        brightness = Double(sender.value)
        changeFilter()
        
    }
    
    @IBAction func contrastButton() {
        addSlider()
    }
    
    func changeContrast(sender: UISlider) {
        contrast = Double(sender.value)
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
        filter.setValue(1.0, forKey: "inputContrast")

        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        imageView.image = UIImage(cgImage: cgImage!)
    }
    
    @IBAction func savePhoto() {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
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
