

import UIKit

class ForgotPasswordVC: UIViewController {
    
    private var viewModel: ForgotPasswordViewModel!
    
    override func viewDidLoad() {
        
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        
        super.viewDidLoad()
        
        txtEmail.layer.cornerRadius=15
        txtEmail.layer.borderColor=UIColor(named: "absa")?.cgColor
        txtEmail.layer.borderWidth=1
        txtEmail.layer.masksToBounds=true
        
        
        btnNext.layer.cornerRadius=15
        btnNext.layer.borderColor=UIColor(named: "absa")?.cgColor
        btnNext.layer.borderWidth=1
        btnNext.layer.masksToBounds=true
        
        let imgIcon=UIImageView()
        imgIcon.image=UIImage (named: "email")
        
        
        imgIcon.tintColor = .gray
        
        let contentView=UIView()
        contentView.addSubview(imgIcon)
        
        contentView.frame=CGRect(x: 10, y: 0, width: 40, height : 25)
        
        imgIcon.frame=CGRect(x: 10, y: 0, width: 40, height : 25)
        
        txtEmail.leftView = contentView
        txtEmail.leftViewMode = .always
        txtEmail.clearButtonMode = .whileEditing
        
        viewModel = ForgotPasswordViewModel(forgotPasswordService: ForgotPasswordDataService())
        
      
        navigationItem.hidesBackButton = true
    }
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    // Function
    @IBAction func btnNext(_ sender: UIButton) {
        guard let userEmail = txtEmail.text, !userEmail.isEmpty else {
            showAlert(title: "Error", message: "Email can't be empty")
            return
        }
        
    // sends a forgot password request
        viewModel.sendForgotPasswordRequest(email: userEmail) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success:
                            self?.showAlert(title: "Success", message: "The one time pin was sent to your email"){
                                if let otpVC = self?.storyboard?.instantiateViewController(withIdentifier: "OTP") {
                                                       self?.navigationController?.pushViewController(otpVC, animated: true)
                                }
                            }
                        case .failure:
                            self?.showAlert(title: "Error", message: "The email is not registered" )
                        }
                    }
                }
            }
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?() // Call the completion handler when the OK button is tapped
        }

        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

