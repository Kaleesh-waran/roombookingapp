//
//  SignUpViewController.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import UIKit

protocol ViewToPresenterSignUpProtocol {
    
    var view: PresenterToViewSignUpProtocol? { get set }
    var interactor: PresenterToInteractorSignUpProtocol? { get set }
    var router: PresenterToRouterSignUpProtocol? { get set }
    
    func signUpButtonTapped(username : String,mailId : String,password : String,confimPassword : String)
    
    func dismissTheSignUpVC()
}


class SignUpViewController: UIViewController {
    
    // MARK: - Properties -
    var presenter: ViewToPresenterSignUpProtocol?
    
    // MARK: - IBOutlets -
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var mailIdField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    // MARK: - Lifecycle Methods -
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpAllUIElements()
    }
    
    // MARK: - IBActions -
    @IBAction func didTappedSignUpButton(_ sender: UIButton) {
        
        guard let username          = usernameField.text,
              let mailId            = mailIdField.text,
              let password          = passwordField.text,
              let confirmPasssword  = confirmPasswordField.text
        else {return}
        presenter?.signUpButtonTapped(username: username, mailId: mailId, password: password, confimPassword: confirmPasssword)
    }
    
    @IBAction func didTappedSignInButton(_ sender: UIButton) {
        presenter?.dismissTheSignUpVC()
    }
    
    // MARK: - Functions -
    private func setUp(){
        
        let presenter = SignUpPresenter()
        let interactor = SignUpInteractor()
        let router = SignUpRouter()

        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self

        interactor.presenter = presenter
        self.presenter = presenter
    }
    
    private func setUpAllUIElements(){
        
        setUp()
        toShowTheDismissButton()
        registerForKeyboardNotifications()
    }
    
    private func toShowTheDismissButton(){
        
        let dismissButton = UIButton(frame: CGRect(x: 10, y: 43, width: 50, height: 50))
        dismissButton.setTitle("Done", for: .normal)
        dismissButton.setTitleColor(.systemBlue, for: .normal)
        view.addSubview(dismissButton)
        dismissButton.addTarget(self, action: #selector(dismissClicked), for: .touchUpInside)
    }
    
    private func registerForKeyboardNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func dismissClicked(){
        
        presenter?.dismissTheSignUpVC()
    }
    
    @objc private func keyBoardWillShow(_ notification : NSNotification){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.view.frame.origin.y = 140 - keyboardSize.height
    }
    
    @objc private func keyBoardWillHide(_ notification : NSNotification){
        
        view.gestureRecognizers?.forEach({ gestureRecognizer in
            if gestureRecognizer is UITapGestureRecognizer {
                view.removeGestureRecognizer(gestureRecognizer)
            }
        })
        self.view.frame.origin.y = 0
    }
    
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension SignUpViewController: PresenterToViewSignUpProtocol{
   
    // TODO: Implement View Output Methods
    func showTheAlertController() {
        
        let alert = UIAlertController(title: "Error occured!", message: "Confirm password is invalid", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in print("Sonai")}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showTheErrorBox() {
        
        let alert = UIAlertController(title: "Error occured!", message: "Invalid UserName or Password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in print("Sonai")}))
        self.present(alert, animated: true, completion: nil)
    }
}
