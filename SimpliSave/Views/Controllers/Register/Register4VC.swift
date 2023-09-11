//
//  Register4VC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit
import AVFoundation

class Register4VC: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var selfie: UIImageView!
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var CreateSavingsAccount: UIButton!
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.black
        IDTextField.layer.borderWidth = 1.0 // Set the border width to make it bold | Rolva
        IDTextField.layer.borderColor = UIColor(hex: "#850856")?.cgColor  // Set the border color to orange | Rolva
        IDTextField.layer.cornerRadius = 15.0
        IDTextField.clipsToBounds = true

        CreateSavingsAccount.layer.cornerRadius = 15.0 // Set the corner radius here | Rolva
        CreateSavingsAccount.clipsToBounds = true // Ensures the corners are rounded | Rolva
        
        view.addSubview(IDTextField)
        view.addSubview(CreateSavingsAccount)
        
        if let pageViewController = parent as? RegisterPageVC {
            pageViewController.setCount = false
        }
    }
    @IBAction func DidTapButton(_ sender: Any) {

        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            print("granted")
            // Camera access is granted. You can use the camera. | Rolva
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true)
            setupCamera()
            break
        case .notDetermined:
            // Camera access is not determined yet. You can request it here. | Rolva
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    // Camera access granted. You can use the camera. | Rolva
                } else {
                    print("dienied")
                    // Camera access denied. Handle this case. | Rolva
                }
            }
        case .denied, .restricted:
            print("denied")
            // Camera access is denied or restricted. Handle this case. | Rolva
            break
        @unknown default:
            break
        }
    }
    
    func setupCamera() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            // Handle the case when no camera is available.
            print("no camera")
            return
        }

        do {
            
            //captures the camera session
            let input = try AVCaptureDeviceInput(device: captureDevice)

            captureSession = AVCaptureSession()
            captureSession?.addInput(input)

            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            previewLayer?.videoGravity = .resizeAspectFill
            previewLayer?.frame = view.bounds
            view.layer.addSublayer(previewLayer!)

            captureSession?.startRunning()
        } catch {
            print("error")
            // Handle the case when an error occurs (e.g., no camera available, etc.).
        }
    }

    // function to control what happens when u click viewWillDisappear: 19/07/2023, Rolva
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession?.stopRunning()
    }

    deinit {
        captureSession = nil
        previewLayer = nil
    }


    // function to control what happens when u click btnnext: 19/07/2023, Rolva
    @IBAction func btnNext(_ sender: Any) {
        let idNumber = IDTextField.text!

           // If the fields are not empty, the entered data is saved to UserDefaults
           if !idNumber.isEmpty {
               if validateSouthAfricanID(idNumber: IDTextField.text!) {
                   // Proceed with the registration
                   let reg4 = [IDTextField.text]

                   if let data = try? NSKeyedArchiver.archivedData(withRootObject: reg4, requiringSecureCoding: false) {
                       UserDefaults.standard.set(data, forKey: "reg4")
                       UserDefaults.standard.synchronize()
                   }

                   if let pageViewController = self.parent as? RegisterPageVC {
                       pageViewController.setCount = true
                       pageViewController.changePage(to: 4, animated: true)
                   }
               } else {
                   showAlert(message: "Please enter a valid South African ID number")
               }
           } else {
               showAlert(message: "Please enter your ID number")
           }
    }
}


/*
 validate ID number
 */
func validateSouthAfricanID(idNumber: String) -> Bool {
    let regex = try! NSRegularExpression(pattern: "^(\\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\\d|3[01])\\d{7})?$")
    let range = NSRange(location: 0, length: idNumber.utf16.count)
    let matches = regex.matches(in: idNumber, options: [], range: range)
    return matches.count == 1
}

// Extension to convert hex color to UIColor, : 18/07/2023 | Rolva
extension UIColor {
    convenience init?(hex: String) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xFF0000) >> 16
        let g = (rgbValue & 0x00FF00) >> 8
        let b = rgbValue & 0x0000FF

        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}

//code to control the behavior of the camera: 18/07/2023 | Rolva
extension Register4VC: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        selfie.image = image
    }
    
    //function to trigger the UI alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "User Details", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

