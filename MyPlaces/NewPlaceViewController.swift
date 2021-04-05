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