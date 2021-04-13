//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Олеся Егорова on 05.04.2021.
//
//
import UIKit

class NewPlaceViewController: UITableViewController {

    var imageIsChanged = false

    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBOutlet weak var placeImage: UIImageView!

    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var placeType: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }

   // MARK: - Table View Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {

            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            // вызываем менюшку по добавлению фото
            // определяем AlertController
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            //определяем пользовательские действия
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }

            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            //вписываем все пользовательские действия в AlertController
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            //вызываем AlertCont
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }

    func saveNewPlace() {

        var image: UIImage?

        if imageIsChanged {
            image = placeImage.image
        } else {
            image = #imageLiteral(resourceName: "imagePlaceholder")
        }

        let imageData = image?.pngData()

        let newPlace = Place(name: placeName.text!,
                             location: placeLocation.text,
                             type: placeType.text,
                             imageData: imageData)

        StorageManager.saveObject(newPlace)

    }

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}

// MARK: - Text Field Delegate

extension NewPlaceViewController: UITextFieldDelegate {

    // Скрывем клавиатуру по нажатию на Done

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc private func textFieldChanged() {

        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

// MARK: - Work with Image

extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func chooseImagePicker(source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true

        imageIsChanged = true

        dismiss(animated: true, completion: nil)
    }
}


