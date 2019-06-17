//
//  Profile module
//  Created by Евгений Котовщиков on 16/06/2019.
//

import UIKit

protocol ProfileDisplayLogic: class {
  func displaySomething(viewModel: Profile.Data.ViewModel)
}

class ProfileViewController: UIViewController {
  
  weak var coordinator: FlowCoordinator?
  var datePicker: UIDatePicker?
  
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var birthTextField: UITextField!
  @IBAction func forceBackButtonHandler(_ sender: Any) {
    
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func choosePhotoHandler(sender: UIButton) {
    coordinator?.goToChooseAvatar()
  }
  
  @IBAction func saveProfileHandler(sender: UIButton) {
    let request = Profile.Data.Save(user: UserModel(name: nameTextField.text, birthDate: birthTextField.text))
    interactor.saveProfileData(request: request)
  }
  
  let interactor: ProfileBusinessLogic
  var state: Profile.ViewControllerState
  
  init(interactor: ProfileBusinessLogic, initialState: Profile.ViewControllerState = .loading) {
    self.interactor = interactor
    self.state = initialState
    super.init(nibName: "ProfileViewController", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    datePicker = UIDatePicker()
    configure(datePicker: datePicker)
    configure(textField: birthTextField)
    configure(controller: self.view)
    let request = Profile.Data.Retrive()
    interactor.retriveProfileData(request: request)
  }
  
  private func configure(datePicker: UIDatePicker?) {
    datePicker?.datePickerMode = .date
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "dd/MM/yyyy"
    if let text = birthTextField.text, let date = dateFormater.date(from: text) {
      datePicker?.date = date
    }
    datePicker?.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    birthTextField.inputView = datePicker
  }
  
  private func configure(textField: UITextField) {
    textField.delegate = self
  }
  
  private func configure(controller: UIView) {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
    controller.addGestureRecognizer(tapGesture)
  }
  
  @objc
  func dateChanged(datePicker: UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    birthTextField.text = dateFormatter.string(from: datePicker.date)
  }
  
  @objc
  func endEditing() {
    view.endEditing(true)
  }
}

extension ProfileViewController: ProfileDisplayLogic {
  func displaySomething(viewModel: Profile.Data.ViewModel) {
    display(newState: viewModel.state)
  }
  
  func display(newState: Profile.ViewControllerState) {
    state = newState
    switch state {
    case .loading:
      print("loading...")
    case let .error(message):
      print("error \(message)")
    case let .result(items):
      print("result: \(items)")
      coordinator?.goToRoot()
    case let .data(data):
      nameTextField.text = data.name
      birthTextField.text = data.birthDate
    }
  }
}

extension ProfileViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField == birthTextField {
      
      if (birthTextField?.text?.count == 2) || (birthTextField?.text?.count == 5) {
        if !(string == "") {
          birthTextField?.text = (birthTextField?.text)! + "/"
        }
      }
      
      if let text = textField.text, let textRange = Range(range, in: text) {
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        if let date = dateFormater.date(from: updatedText) {
          datePicker?.date = date
        }
      }
      
      return !(textField.text!.count > 9 && (string.count ) > range.length)
    } else {
      return true
    }
  }
}

