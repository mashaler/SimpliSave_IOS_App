//
//  LoginVC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//


import UIKit
import Alamofire
class LoginVC: UIViewController {
    


    
    var viewModel = userGetDetails()
    var savings: SavingsViewModel!
    var passwordToggleImageView: UIImageView!
    var getGoal:SavingsService!
    

    
    var overTarget = false
    var thisMonthCount: Double = 0.0
    var savingsData: Savings!
    var saving: SavingViewModel!
    var currentSaved = 0.0
    var amountSet = 0.0
    var totalSaved = 0.0
    var Id = 0
    var isUpdated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.removeObject(forKey: "user_token")
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
       
        if let isLogined=UserDefaults.standard.string(forKey:"user_token"){
            print(isLogined)
        }
        else{
            print("nil")
        }

        
        
        //saving token expiration time Robert 04/09/2023
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC+2")

        // Define the initial date
        let initialDate = Date()

        // Add 30 minutes to the initial date
        let calendar = Calendar.current
        let newDate = calendar.date(byAdding: .minute, value: 30, to: initialDate)

        if let newDate = newDate {
            let formattedDate = dateFormatter.string(from: newDate)
            UserDefaults.standard.set(formattedDate, forKey: "tokenExpire")

            print(formattedDate)
        } else {
            print("Failed to calculate the new date.")
        }
     
        
      
        txtEmail.layer.cornerRadius=15
        txtEmail.layer.borderColor=UIColor(named: "absa")?.cgColor
        txtEmail.layer.borderWidth=1
        txtEmail.layer.masksToBounds=true
        
        txtPassword.layer.cornerRadius=15
        txtPassword.layer.borderColor=UIColor(named: "absa")?.cgColor
        txtPassword.layer.borderWidth=1
        txtPassword.layer.masksToBounds=true
        
        //button styles
        btn_login.layer.cornerRadius=15
        btn_login.layer.borderColor=UIColor(named: "absa")?.cgColor
        btn_login.layer.borderWidth=1
        btn_login.layer.masksToBounds=true
        
        btnRegister.layer.cornerRadius=15
        btnRegister.layer.borderColor=UIColor(named: "absa")?.cgColor
        btnRegister.layer.borderWidth=1
        btnRegister.layer.masksToBounds=true
        
        let imgIcon=UIImageView()
        imgIcon.image=UIImage (named: "email")
      
        //imageView.image = originalImage?.withRenderingMode(.alwaysTemplate)

        // Set the tint color for the image (replace .red with your desired color)
        imgIcon.tintColor = .gray
        
        let contentView=UIView()
        contentView.addSubview(imgIcon)
        
        contentView.frame=CGRect(x: 10, y: 0, width: 40, height : 25)
        
        imgIcon.frame=CGRect(x: 10, y: 0, width: 40, height : 25)

        txtEmail.leftView = contentView
        txtEmail.leftViewMode = .always
        
        //password
        let imgIcon2=UIImageView()
        imgIcon2.image=UIImage (named: "lock 1")
        imgIcon2.tintColor = .gray

        
        let contentView2=UIView()
        contentView2.addSubview(imgIcon2)
        
        contentView2.frame=CGRect(x: 10, y: 0, width: 40, height : 25)
        
        imgIcon2.frame=CGRect(x: 10, y: 0, width: 40, height : 25)

        txtPassword.leftView = contentView2
        txtPassword.leftViewMode = .always
        navigationItem.hidesBackButton = true
        
        setupPasswordTextField()
        
        // Do any additional setup after loading the view.
    }
    
    /*@IBOutlet weak var lblPasswordError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!*/
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
  
    //forgot password button
    
    @IBAction func btnForgotPassword(_ sender: UIButton) {
    }
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btn_login:UIButton!
    var errorMsgEmail=""
    var errorMsgPassword=""

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    //login button
    @IBAction func btn_Login(_ sender: UIButton) {

        
        let userName=txtEmail.text
        
        let password=txtPassword.text
        
        //display error message
        if(userName!.isEmpty || password!.isEmpty){
            let alertController = UIAlertController(
                title: "Error: Empty Fields",
                     message: "Please fill in all the fields",
                     preferredStyle: .alert
                
                 )
            
            //`setting the color of heading to red
            let attributedString = NSAttributedString(
                string: "Error",
                attributes: [
                    .foregroundColor: UIColor.red
                ]
            )

            // Set the attributed title for the alert controller
            alertController.setValue(attributedString, forKey: "attributedTitle")
            
            // Add an action button to the alert
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
               
            }
            
            // Add the action button to the alert controller
            alertController.addAction(okAction)
            // Present the alert controller
            present(alertController, animated: true, completion: nil)
        }
        //if there are no errors, proceed to checking if the entered credentials are correct... 02/08/2023 Robert
        else{

           
          
           
            //login with jsonfile
//            let viewModel = uViewModel()
//            var getUserName=""
//            var getPassword=""
//            viewModel.getData {
//                if let userDetails = viewModel.getUserDetails {
//                    print("TESTING: \(userDetails.firstName)")
//
//                    getPassword=userDetails.password
//                    getUserName=userDetails.email
//                }
//            }
//
//            if(getUserName == txtEmail.text  && getPassword==txtPassword.text  ){
//                performAfterSuccessfulLogin()
//                //proceed to the next page
//            }
//
//            else{
//                showAlert(msg: "Invalid login details, please try again!")
//            }
            
            
            
            
            
            
            
            
//            if let isLogined=UserDefaults.standard.string(forKey:"user_token"){
//                print(isLogined)
//            }
//                else{
//                showAlert(msg: "Invalid login details, please try again")
//
//            }

         //checking if email is in correct format
            if isValidEmail(email: userName!) {
                // Proceed to the next screen
                /*
                 created 10 08 2023
                 updated: 15 08 2023
                 Dev: Robert
                 Function name: Login
                 Description: Calling the login function and passing the user details entered by the user to authenticate
                 Parameters: username(email) and password
                 */
                let authViewModel = AuthViewModel()
                authViewModel.login(username: txtEmail.text!, password: txtPassword.text!) { result in
                    DispatchQueue.main.async {
                        do {
                            switch result {
                            case .success(let message):
                                print(message)
                                self.performAfterSuccessfulLogin()
                                
                            case .failure(let error):
                                print("Login error: \(error)")
                                self.showAlert(msg: "Invalid login details, Please try again!")
                            }
                        } catch {
                            // Handle any potential errors
                        }
                    }
                }
            }


            else {
                let alertController = UIAlertController(
                    title: "Error:",
                         message: "Please enter a valid email address",
                         preferredStyle: .alert

                     )

                //`setting the color of heading to red
                let attributedString = NSAttributedString(
                    string: "Error",
                    attributes: [
                        .foregroundColor: UIColor.red
                    ]
                )

                // Set the attributed title for the alert controller
                alertController.setValue(attributedString, forKey: "attributedTitle")

                // Add an action button to the alert
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in

                }

                // Add the action button to the alert controller
                alertController.addAction(okAction)
                // Present the alert controller
                present(alertController, animated: true, completion: nil)
            }
            
        }
        
       
        
    }
    
   

    func isValidEmail(email: String) -> Bool {
        // Regular expression pattern for basic email validation
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: email.utf16.count)

        return regex.firstMatch(in: email, options: [], range: range) != nil
    }

    func  showAlert(msg:String){
        let alertController = UIAlertController(
            title: "Error",
                 message: msg,
                 preferredStyle: .alert
            
             )
        
        //`setting the color of heading to red
        let attributedString = NSAttributedString(
            string: "Error",
            attributes: [
                .foregroundColor: UIColor.red
            ]
        )

        // Set the attributed title for the alert controller
        alertController.setValue(attributedString, forKey: "attributedTitle")
        
        // Add an action button to the alert
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
           
        }
        
        // Add the action button to the alert controller
        alertController.addAction(okAction)
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    func setupPasswordTextField() {
        
        // Creates a view to hold the password toggle icon - Masana - 10/08/2023
        
            let passwordRightView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 24))
            let passwordContentView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 24))
            
        // Creates an image view for the password toggle icon - Masana - 07/08/2023
        
            passwordToggleImageView = UIImageView(image: UIImage(named: "closedeye"))
            passwordToggleImageView.contentMode = .scaleAspectFit
            passwordToggleImageView.frame = CGRect(x: 6, y: 0, width: 24, height: 24)
            passwordContentView.addSubview(passwordToggleImageView)
            
        // Adds a tap gesture recognizer to toggle the password visibility - Masana - 10/08/2023
        
            let passwordTapGesture = UITapGestureRecognizer(target: self, action: #selector(passwordToggleTapped))
            passwordContentView.addGestureRecognizer(passwordTapGesture)
        
        // Puts the password toggle icon view and add it as the right view of the password field - Masana - 10/08/2023
        
            passwordRightView.addSubview(passwordContentView)
            txtPassword.rightView = passwordRightView
            txtPassword.rightViewMode = .always
            txtPassword.isSecureTextEntry = true
        }
    // Function to toggle the visibility of the password text in the passwordTextField - Masana - 10/08/2023
    
    @objc func passwordToggleTapped() {
            txtPassword.isSecureTextEntry.toggle()
            let imageName = txtPassword.isSecureTextEntry ? "closedeye" : "openeye"
            passwordToggleImageView.image = UIImage(named: imageName)
        }

    //nagivate to dashboard after login...robert
    func performAfterSuccessfulLogin() {

        
        /*
         Author: Robert
         Date: 29/08/2023
         checking if the entered email is for admin then redirect to admin dashboard
         */
        if(txtEmail.text=="admin@gmail.com"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let dashboard = storyboard.instantiateViewController(withIdentifier: "AdminDashboard") as? AdminDashboardVC {
                self.navigationController?.pushViewController(dashboard, animated: true)
            }
            print("user is admin")

        }
        else{
            
            viewModel.fetchData { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching data: \(error)")
                    return
                }
      
                
                
                if let userName=viewModel.userProfile?.firstName, userName.isEmpty{
                    DispatchQueue.main.async {
                        
                        self.showAlert(msg: "There's a problem with the network, please try again")
                        
                    }
                }
                
                else{
                    
                    //Saving target Robert

                    SavingsService().fetchSavingsData(completion: { data in
                        
                        self.savings = SavingsViewModel(savings: data?.data ?? [])
                        DispatchQueue.main.async {

                            print(self.savings.savings.count)
                            if (self.savings.savings.count == 0){
                                SavingsService().addNewGoal(ToAdd:UserDefaults.standard.integer(forKey: "reg7"))
                            }
                            
                            else{
                                print("SAVING TARGET HAS BEEN ADDED")
                            }
                        }
                    })
                    DispatchQueue.main.async {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let dashboard = storyboard.instantiateViewController(withIdentifier: "TabBar") as? TabBar {
                            self.navigationController?.pushViewController(dashboard, animated: true)
                        }
                        print("user is student")
                    }
    }
    
               
    
            }
          
            
        }
            
        
    }
    



}
