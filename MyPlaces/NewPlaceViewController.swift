//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Олеся Егорова on 05.04.2021.
//

import UIKit

class NewPlaceViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()

        
    }
    
   // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // вызываем менюшку по добавлению фото
            // определяем AlertController
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            //определяем пользовательские действия
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            //вписываем все пользовательские действия в AlertController
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            //вызываем AlertCont
            present(actionSheet, animated: true)
            
        }  else {
            view.endEditing(true)
        }
    }
}

// MARK: - Text Field Delegate

extension NewPlaceViewController: UITextFieldDelegate {
    
    // Скрывем клавиатуру по нажатию на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Work with Image

extension NewPlaceViewController {
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }
}
