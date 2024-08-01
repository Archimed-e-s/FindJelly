import UIKit

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var imagePickerController: UIImagePickerController?
    var completion: ((UIImage) -> Void)? // Closure for send current UIImage into ViewController

    func showImagePicker(in viewController: UIViewController, completion: @escaping ((UIImage) -> Void)) {
        self.completion = completion
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        let alert = UIAlertController(
            title: "Выбрать фото из галереи?",
            message: "Вы можете сделать фото или выбрать уже имеющееся",
            preferredStyle: .alert
        )
        let takePhotoButton = UIAlertAction(title: "Фото", style: .default) { _ in
            self.imagePickerController?.sourceType = .camera
            viewController.present(self.imagePickerController!, animated: true)
        }
        alert.addAction(takePhotoButton)
        let takeFromLibrary = UIAlertAction(title: "Библиотека", style: .default) { _ in
            self.imagePickerController?.sourceType = .photoLibrary
            viewController.present(self.imagePickerController!, animated: true)
        }
        alert.addAction(takeFromLibrary)
        viewController.present(alert, animated: true)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = info[.originalImage] as? UIImage {
            self.completion?(image)
            picker.dismiss(animated: true)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController?.dismiss(animated: true)
    }
}
