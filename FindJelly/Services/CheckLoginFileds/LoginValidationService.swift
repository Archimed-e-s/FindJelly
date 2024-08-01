import UIKit

final class LoginValidationService {

    static let shared = LoginValidationService()
    private init() { }

    private func isValid(_ type: String, _ data: String) -> Bool {
        var dataRegEx = ""
        switch type {
        case "e":
            dataRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        default:
            dataRegEx = "(?=.*[A-Z0-9a-z]).{6,}"
        }
        let dataPred = NSPredicate(format:"SELF MATCHES %@", dataRegEx)
        return dataPred.evaluate(with: data)
    }

    func validField( _ field: UITextField) -> Bool {
        let id = field.placeholder?.lowercased()
        switch id {
        case "Логин":
            if field.text?.count ?? 0 < 3 {
                validView(field, false)
                return false
            } else {
                validView(field, true)
                 return true
            }
        case "email":
            if isValid("e", field.text!) {
               validView(field, true)
                return true
            } else {
                validView(field, false)
                return false
            }
        case "пароль":
            if isValid("p", field.text!) {
                validView(field, true)
                return true
            } else {
                validView(field, false)
                return false
            }
        default:
            if field.text?.count ?? 0 < 2 {
                validView(field, false)
                return false
            } else {
                validView(field, true)
                return true
            }
        }
    }

    private func validView(_ field: UITextField, _ valid: Bool) {
        if valid {
            field.backgroundColor = R.color.textFieldsColor()
        } else {
            field.backgroundColor = R.color.notValidTextFieldsColor()
        }
    }
}
