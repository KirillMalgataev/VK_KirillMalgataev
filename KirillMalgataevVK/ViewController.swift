//
//  ViewController.swift
//  KirillMalgataevVK
//
//  Created by Kirill Malgataev on 05.07.2020.
//  Copyright © 2020 Kirill Malgataev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    class ViewController: UIViewController {
        @IBOutlet weak var scrollView: UIScrollView!
        @IBOutlet weak var passwordField: UITextField!
        @IBOutlet weak var emailField: UITextField!
        
        // переопределили метод viewWillAppear
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
//NotificationCenter - это обьект который умеет получать и присылать уведомления. Это его единственая функция.
// default - это обьект NotificationCenter с которым работает вся система
// addObserver - метод который добавляет класс который обозревает нотификации определенного типа
// selector - клавиатура открыта или закрыта
// name - это имя нотификации которое мы будем отслеживать
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            scrollView.addGestureRecognizer(tapGesture)
        }

        @objc func keyboardWillShown(notification: Notification) {
            let info = notification.userInfo! as NSDictionary
// получаем размер клавиатуры
            let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
// обьект с отступами. отступаем только снизу на размер клавиатуры параметр bottom
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0)
// дополнительные отступы в рамках внутреннего размера
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }

        @objc func keyboardWillHide(notification: Notification) {
            scrollView.contentInset = UIEdgeInsets.zero
            scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        }
// мы должны отписаться от нотификаций как только мы уйдем с нашего экрана
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        }

        @objc func hideKeyboard() {
            scrollView.endEditing(true)
        }


        @IBAction func login(_ sender: UIButton) {
            guard let emailText = emailField.text else { return }
            guard let pwdText = passwordField.text else { return }

            if emailText == "kirill", pwdText == "1" {
                print("Успешно!")
            }
            else {
                print("Не успешно")
            }
        }
    }
}
