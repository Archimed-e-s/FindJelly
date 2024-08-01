import UIKit
import PencilKit

final class PhotoEditingViewController: UIViewController {

    // MARK: - Private properties

    private var imageForSaving = UIImage()
    private let imagePicker = ImagePicker()

    private lazy var canvasView: PKCanvasView = {
        let canvasView = PKCanvasView(frame: editableImage.frame)
        canvasView.maximumZoomScale = 5
        canvasView.minimumZoomScale = 1
        canvasView.isOpaque = false
        return canvasView
    }()

    private lazy var editableImage:UIImageView = {
        let image = UIImageView(image: UIImage())
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var selectImageButton: UIButton = {
        let button = UIButton()
        button.setPrimaryButton("+", UIFont(name: "Avenir-Light", size: 36), 25)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(selectImageButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var pencilImageButton: UIButton = {
        let button = UIButton()
        button.setPrimaryButtonWithIcon("paintbrush.pointed.fill", 25)
        button.addTarget(self, action: #selector(pencilButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var clearImageButton: UIButton = {
        let button = UIButton()
        button.setPrimaryButtonWithIcon("eraser.fill", 25)
        button.addTarget(self, action: #selector(clearButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var addFilterButton: UIButton = {
        let button = UIButton()
        button.setPrimaryButtonWithIcon("wand.and.stars", 25)
        button.addTarget(self, action: #selector(addFilterButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var saveImageButton: UIButton = {
        let button = UIButton()
        button.setDefaultButton("Сохранить", R.color.primaryColor(), UIFont(name: "Arial", size: 18))
        button.addTarget(self, action: #selector(saveImageButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var mainView = {
        let view = UIView()
        return view
    }()

    override func loadView() {
        view = mainView
        view.backgroundColor = .white
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
    }

    // MARK: - Private Methods

    private func addSubviews() {
        [
        editableImage,
        selectImageButton,
        saveImageButton
        ].forEach({ view.addSubview($0) })
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            saveImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            saveImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            saveImageButton.heightAnchor.constraint(equalToConstant: 50),
            saveImageButton.widthAnchor.constraint(equalToConstant: 90),

            selectImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            selectImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            selectImageButton.heightAnchor.constraint(equalToConstant: 50),
            selectImageButton.widthAnchor.constraint(equalToConstant: 50),

            editableImage.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 10),
            editableImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editableImage.heightAnchor.constraint(equalToConstant: 500.fitH),
            editableImage.widthAnchor.constraint(equalToConstant: 375.fitW)
        ])
    }

    private func setPencilButton() {
        NSLayoutConstraint.activate([
            pencilImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            pencilImageButton.leadingAnchor.constraint(equalTo: selectImageButton.trailingAnchor, constant: 10),
            pencilImageButton.heightAnchor.constraint(equalToConstant: 50),
            pencilImageButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setClearButton() {
        NSLayoutConstraint.activate([
            clearImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            clearImageButton.leadingAnchor.constraint(equalTo: pencilImageButton.trailingAnchor, constant: 10),
            clearImageButton.heightAnchor.constraint(equalToConstant: 50),
            clearImageButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setFilterButton() {
        NSLayoutConstraint.activate([
            addFilterButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            addFilterButton.leadingAnchor.constraint(equalTo: clearImageButton.trailingAnchor, constant: 10),
            addFilterButton.heightAnchor.constraint(equalToConstant: 50),
            addFilterButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setUpDrawing() {
        guard
            let window = view.window,
            let toolPicker = PKToolPicker.shared(for: window) else {
            return
        }
        view.addSubview(canvasView)
        canvasView.insertSubview(editableImage, at: 1)
        canvasView.sendSubviewToBack(editableImage)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        canvasView.resignFirstResponder()
        canvasView.becomeFirstResponder()
    }

    private func mergeImages() {
        let format = UIGraphicsImageRendererFormat.default()
        format.opaque = false
        let rect = CGRect(origin: .zero, size: CGSize(width: 375.fitW, height: 500.fitH))
        let image = UIGraphicsImageRenderer(size: self.editableImage.frame.size, format: format).image { _ in
            editableImage.image?.draw(in: rect, blendMode: .normal, alpha: 1.0)
            canvasView.drawing.image(from: rect, scale: .zero).draw(at: .zero)
        }
        imageForSaving = image
    }

    private func clearCanvas() {
        editableImage.removeFromSuperview()
        canvasView.drawing = PKDrawing()
        canvasView.removeFromSuperview()
    }

    // MARK: - Actions

    @objc private func selectImageButtonDidTap() {
        imagePicker.showImagePicker(in: self) { [weak self] image in
            guard let self = self else { return }
            editableImage.image = image
            view.addSubview(pencilImageButton)
            setPencilButton()
        }
    }

    @objc private func pencilButtonDidTap() {
        setUpDrawing()
        view.addSubview(clearImageButton)
        view.addSubview(addFilterButton)
        setClearButton()
        setFilterButton()
    }

    @objc private func addFilterButtonDidTap() {
        
    }

    @objc private func clearButtonDidTap() {
        canvasView.drawing = PKDrawing()
    }

    @objc private func saveImageButtonDidTap() {
        mergeImages()
        UIImageWriteToSavedPhotosAlbum(imageForSaving, nil, nil, nil)
        clearCanvas()
        let alert = UIAlertController(title: "", message: "Изображение сохранено", preferredStyle: .alert)
        present(alert, animated: true)
        alert.dismiss(animated: true)
        pencilImageButton.removeFromSuperview()
        clearImageButton.removeFromSuperview()
        addFilterButton.removeFromSuperview()
    }
}
