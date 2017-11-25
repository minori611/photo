//
//  editPhotoViewController.swift
//  photo
//
//  Created by Minori_n on 2017/09/09.
//  Copyright © 2017年 那須美律. All rights reserved.
//まも助けてくださいお願いします！
//

import UIKit

class editPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var cameraImageView: UIImageView!
    
    var originalImage: UIImage!
    var filter: CIFilter!
    var slider = 0.0
    var brightness = 0.0
    var contrast = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openAlbum()
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
        cameraImageView.image = Info[UIImagePickerControllerEditedImage] as? UIImage
        
        originalImage = cameraImageView.image
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sliderchanged(_ sender: UISlider) {
        
        slider = Double(sender.value)
        print(sender.value)
    }
    
    @IBAction func changeBrightness() {
        
        //brightness = Double(slider)
        changeFilter()
    }
    
    @IBAction func changeContrast() {
        
        contrast = Double(slider)
        changeFilter()
    }
    
    @IBAction func changeFilter() {
        let filterImage: CIImage = CIImage(image: originalImage)!
        
        //filter
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        //brightness
        filter.setValue(1.0, forKey: "inputBrightness")
        
        //contrast
        filter.setValue(1.0, forKey: "inputContrast")

        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
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
