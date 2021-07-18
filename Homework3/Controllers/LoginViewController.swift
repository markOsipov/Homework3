import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    private let defaultLogin = "User"
    private let defaultPassword = "Kitties"

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 5
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let welcomeVC = segue.destination as? WelcomeViewController else {
            return
        }
        segue.perform()
        welcomeVC.welcomeUser(loginTextField.text!)
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        if authenticate(login: loginTextField.text, password: passwordTextField.text) {
            performSegue(withIdentifier: "goToWelcomeView", sender: self)
        } else {
            showAlert(title: "Authentication error",
                      message: "Login or password is incorrect")
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)

        view.endEditing(true)
    }

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        loginTextField.text = ""
        passwordTextField.text = ""
    }

    @IBAction func remindLogin(_ sender: Any) {
        showAlert(title: "Don't panic!", message: "\n\nYour login is \(defaultLogin)")
    }

    @IBAction func remindPassword(_ sender: Any) {
        showAlert(title: "Don't panic!", message: "\n\nYour password is \(defaultPassword)")
    }

    private func authenticate(login: String?, password: String?) -> Bool {
        login == defaultLogin && password == defaultPassword
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if loginTextField.isEditing {
            passwordTextField.becomeFirstResponder()

        } else if passwordTextField.isEditing {
            performSegue(withIdentifier: "goToWelcomeView", sender: self)
        }

        return true
    }
}
