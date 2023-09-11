//
//  MyDetailsVC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

// MARK: - Import Statements

import UIKit
import Foundation
import Alamofire

// MARK: - Class Declaration


class MyDetailsVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
 
// MARK: - Outlets
    
    @IBOutlet weak var btnUserProfile: UIImageView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var cellPhoneTF: UITextField!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var updateDetailsButton: UIButton!
    
      // MARK: - Properties
    
    private var viewModel = userGetDetails()
    
      // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //Robert 04/09/2023 checking if the token expired, and redirected to login
        let token = TokenManager()
        //token.redirectLogin()
        if token.isExpire {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let dashboard = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginVC {
                self.navigationController?.pushViewController(dashboard, animated: true)
            }        } else {
            print("Still Valid")
        }
        // MARK: Data Fetching
        
        viewModel.fetchData { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            DispatchQueue.main.async {

                //displaying the image loaded from the API to the user Robert 28/08/2023
                
                let imageUrlString = self.viewModel.userProfile?.imageUrl ?? ""
                let trimmedImageUrlString = imageUrlString.replacingOccurrences(of: "http://res.cloudinary.com/", with: "")

                        if let imageUrl = URL(string: "https://res.cloudinary.com/" + trimmedImageUrlString) {
                            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                                if let error = error {
                                    print("Error fetching image:", error)
                                    return
                                }

                                if let data = data, let image = UIImage(data: data) {
                                    DispatchQueue.main.async {
                                        self.btnUserProfile.image=image

                                    }
                                }
                            }.resume()
                        }
                print(imageUrlString)

                self.updateUI()

            }
        }

       // MARK: Text Field Styling
       
        //Author: Ofentse Malebye
        // Date : 25 July 2023
        
       //controlling the size,width, color and border radius of the text fields: 15/08/2023 | Rolva
        firstNameTF.layer.borderWidth = 1
        firstNameTF.layer.borderColor = UIColor(named: "AppColor")?.cgColor
        firstNameTF.layer.cornerRadius = 15
        firstNameTF.clipsToBounds = true
        
        
        lastNameTF.layer.borderWidth = 1
        lastNameTF.layer.borderColor = UIColor(named: "AppColor")?.cgColor
        lastNameTF.layer.cornerRadius = 15
        lastNameTF.clipsToBounds = true
        
        cellPhoneTF.layer.borderWidth = 1
        cellPhoneTF.layer.borderColor = UIColor(named: "AppColor")?.cgColor
        cellPhoneTF.layer.cornerRadius = 15
        cellPhoneTF.clipsToBounds = true
        
        
        changePasswordButton.layer.cornerRadius = 10
        changePasswordButton.clipsToBounds = true
        changePasswordButton.layer.borderWidth = 1
        changePasswordButton.layer.borderColor = UIColor(named: "AppColor")?.cgColor
        
        updateDetailsButton.layer.cornerRadius = 10
        updateDetailsButton.clipsToBounds = true
        
        // MARK: Button Styling
        
        btnUserProfile.layer.cornerRadius=65.0
        btnUserProfile.layer.masksToBounds=true
        btnUserProfile.layer.shadowOpacity=0.2
        btnUserProfile.layer.shadowOffset.width=1
        btnUserProfile.layer.shadowOffset.height=1.5
        
        
        let uTapGesture = UITapGestureRecognizer(target: self, action: #selector(userProfileTapped))
        btnUserProfile.isUserInteractionEnabled = true
        btnUserProfile.addGestureRecognizer(uTapGesture)
        
        
        //calling the setup function: 17/08/2023 | Rolva
        setupUI()
     
    }
    // MARK: - UI Setup
       
    // Set up the UI appearance
    private func setupUI() {

    }
    
    // MARK: - Button Actions
    
    //Author: Ofentse Malebye
    // Date : 27 July 2023
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        
        
        
       // Validating the fields to check if they are empty or not, show an error message if they are empty
        if(cellPhoneTF.text!.isEmpty||firstNameTF.text!.isEmpty||lastNameTF.text!.isEmpty){
            showAlert(message: "Please fill in all the fields")
    }
   
        
        // Check if the cell number is in a valid format using a regular expression pattern - Robert - 2/08/2023
        let cellPattern = "^0\\d{9}$"
                let cellPredicate = NSPredicate(format: "SELF MATCHES %@", cellPattern)
        if !cellPredicate.evaluate(with: cellPhoneTF.text) {
                    showAlert(message: "Please enter a valid cellphone number.")
                    return
    }
        
        let date = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC+2")
        let createdAt = dateFormatter.string(from: date)
        
        let updated = UserRegister(firstName: firstNameTF.text ?? "", lastName: lastNameTF.text ?? "", cellphoneNumber: cellPhoneTF.text ?? "",  email:viewModel.userProfile?.email ?? "", imageUrl: "" , idNo: viewModel.userProfile?.email ?? "", password: viewModel.userProfile?.password ?? "", createdAt: viewModel.userProfile?.createdAt ?? "", updatedAt: createdAt)
        
        userGetDetails().update(user: updated)
        showAlert(message: "Details updated successfully!")

    }
    
    // MARK: - Alert
    
    //function to trigger the UI alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "User Details", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(_ emailAddress: String) -> Bool {
        // Implement your email validation logic here (e.g., using regular expressions)
        // For simplicity, we'll just check for a minimum length of 5 characters
        return emailAddress.count >= 5
    }
    
    
    //function to print the information of the user: 02/08/2023 | Rolva
    func printUserInformation(_ userDict: [String: String]) {
        print("User Information:")
        print("First Name: \(userDict["firstName"] ?? "")")
        print("Last Name: \(userDict["lastName"] ?? "")")
        print("Cellphone: \(userDict["cellphone"] ?? "")")
        print("Email Address: \(userDict["email"] ?? "")")
    }
    
    
    // MARK: - User Profile Image Handling
        
    //function that allows the user to upload the profile picture
    @objc func userProfileTapped() {
        let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self

            let actionSheet = UIAlertController(title: "Profile Picture", message: "Choose a profile picture", preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (action: UIAlertAction) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    imagePickerController.sourceType = .camera
                    self.present(imagePickerController, animated: true, completion: nil)
                }
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { (action: UIAlertAction) in
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Image Picker Delegate
    
    // UIImagePickerControllerDelegate method to handle image selection
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            let scaledImage = selectedImage.resizeToFill(targetSize: btnUserProfile.frame.size)
            btnUserProfile.image = scaledImage
            
            // Store the selected image in the API robert 28/08/2023

            if let selectedImage = btnUserProfile.image,
                let imageData = selectedImage.pngData() {
                //getting the stored url from info file 29/08/2023 Robert
                let url = Bundle.main.object(forInfoDictionaryKey: "uploadImage") as! String

                
                AF.upload(
                    multipartFormData: { multipartFormData in
                        multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                    },
                    to: url,
                    method: .post,
                    headers: nil
                )
                .response { response in
                    // Handle the response from the server
                    switch response.result {
                    case .success(let value):
                        if let data = value {
                            if let responseString = String(data: data, encoding: .utf8) {
                                print("Response from server: \(responseString)")
                            }
                        }
                    case .failure(let error):
                        print("Upload failed with error: \(error)")
                    }
                }
            }

        }
        
        picker.dismiss(animated: true, completion: nil)
    }

       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
    
    // MARK: - Update UI
    
    //updating the UI
    private func updateUI() {

        firstNameTF.text = viewModel.userProfile?.firstName ?? ""
        lastNameTF.text = viewModel.userProfile?.lastName ?? ""
        cellPhoneTF.text = viewModel.userProfile?.cellphoneNumber ?? ""
      
    }
}

   // MARK: - UIImage Extension
extension UIImage {
    
    //function that allows the uploaded profile picture to stick to the original size of the image view:21/08/2023 | Rolva
    func resizeToFill(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height

        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? self
    }
    

}



    

