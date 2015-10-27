//
//  ViewController.swift
//  FirstApplication
//
//  Created by Tran Vinh Quang on 10/26/15.
//  Copyright © 2015 Tran Vinh Quang. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var imgLabel: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func Cancel(sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)

        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        txtName.delegate = self
        if let meal = meal {
            navigationItem.title = meal.name
            txtName.text = meal.name
            imgLabel.image = meal.photo
            ratingControl.rating = meal.rating
            
        }
        
        checkValidMealName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: Action
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
      checkValidMealName()
        navigationItem.title = txtName.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func checkValidMealName() {
        let text = txtName.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    @IBAction func tapImage(sender: UITapGestureRecognizer) {
        txtName.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        presentViewController(imagePickerController, animated: true, completion: nil)
        imagePickerController.delegate = self
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgLabel.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = txtName.text ?? ""
            let photo = imgLabel.image
            let rating = ratingControl.rating
            
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
    
}

