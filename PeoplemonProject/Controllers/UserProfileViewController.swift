//
//  UserProfileViewController.swift
//  PeoplemonProject
//
//  Created by Melissa Anderson on 11/8/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//


import UIKit


class UserProfileViewController: UIViewController {
    
 /*   override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.text = User.title
        View.text = User.text
        
        if let image = User.image {
            ImageView.image = image
            addGestureRecognizer()
        }else{
            ImageView.isHidden = false
        }
    }
        
       // var imageView

    }

*/
   /*
        
        @IBAction func choosePhoto(_ sender: Any) {
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewImage() {
        if let image = ImageView.image {
            ToDoStore.shared.selectedImage = image
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageNavController")
            present(viewController, animated: true, completion: nil)
        }
    }
    fileprivate func showPicker(_ type: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        People.image = ImageView.image
     
        
    }
    
    // MARK: - IBActions
    
    
    @IBAction func choosePhoto(_ sender: AnyObject) {
        
        let alert = UIAlertController(title: "Picture", message: "Choose a picture type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler:
            { (action) in self.showPicker(.camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:
            { (action) in self.showPicker(.photoLibrary)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    //Mark: - Date Picker
    

// can copy this and use over and over
//Mark: - Image Picker
extension UserProfileViewController: UIViewController,
UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        //copied from slack ->
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            let maxSize: CGFloat = 512
            let scale = maxSize/image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: maxSize, height: newHeight))
            let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            ImageView.image = resizeImage
            
            ImageView.isHidden = false
            
            if gestureRecognizer != nil {
                ImageView.removeGestureRecognizer(gestureRecognizer)
            }
            addGestureRecognizer()
        }
        
        
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
    
    //profileimage.image  add to code for pic
    
} */

}
