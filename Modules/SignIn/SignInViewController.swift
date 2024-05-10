//
//  SignInViewController.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 11/04/23.
//  
//

import UIKit

protocol ViewToPresenterSignInProtocol {
    
    var view: PresenterToViewSignInProtocol? { get set }
    var interactor: PresenterToInteractorSignInProtocol? { get set }
    var router: PresenterToRouterSignInProtocol? { get set }
    
    //MARK: Forward to presenter when signIn button is tapped by the user
    func signInButtonTapped(username : String,password : String)
    
    //MARK: Forward to presenter when user comes after killing the app
    func toCheckTheUserSignIn()
    
    //MARK: Forward to presenter when signUp button is tapped by the user
    func signUpButtonTapped()
}

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets -
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: - Properties -
    var presenter: ViewToPresenterSignInProtocol?
    
    // MARK: - Lifecycle Methods -
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpAllUIElements()
        CoreDataManager.shared.loadAllBuildings()
        
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") {
            presenter?.toCheckTheUserSignIn()
        }
    }

    // MARK: - IBActions -
    
    //MARK: Trigger when signin button is tapped
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        guard let username = usernameField.text , let password = passwordField.text else {return}
        presenter?.signInButtonTapped(username: username, password: password)
    }
    
    //MARK: Trigger when signup button is tapped
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        presenter?.signUpButtonTapped()
    }
    
    //MARK: - Functions -
    
    //MARK: function that coordinates all the files in this modules
    private func setUp(){
        
        let presenter = SignInPresenter()
        let interactor = SignInInteractor()
        let router = SignInRouter()

        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self

        interactor.presenter = presenter
        self.presenter = presenter
    }
    
    //MARK: function to set up all the UIElements
    private func setUpAllUIElements(){
        
        setUp()
        registerForKeyboardNotifications()
    }
    
    //MARK: function to Handle keyboard events
    private func registerForKeyboardNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShown(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: @objc methods
    
    @objc private func keyBoardWillShown(_ notification : NSNotification) {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyBoardWillHide(_ notification : NSNotification){
        
        view.gestureRecognizers?.forEach({ gestureRecognizer in
            
            if gestureRecognizer is UITapGestureRecognizer {
                view.removeGestureRecognizer(gestureRecognizer)
            }
        })
    }
    
    @objc private func dismissKeyboard(){
        
        view.endEditing(true)
    }
}

extension SignInViewController: PresenterToViewSignInProtocol{
    
    // TODO: Implement View Output Methods
    
    //MARK: Event Receive from the presenter to present the alertcontroller
    func toShowTheAlertController() {
        
        let alert = UIAlertController(title: "Error occured!", message: "Invalid UserName or Password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in print("Sonai")}))
        self.present(alert, animated: true, completion: nil)
    }
    
}

