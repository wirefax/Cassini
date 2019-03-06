//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Maksym Logvin on 3/6/19.
//  Copyright © 2019 Maksym Logvin. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    
    //Подготавливаем переезд с выбранного пункта меню на Мастере в СплитВью
    //Получаем идентификатор переезда чтобы знать какая кнопка была нажата
    //сравниваем его с ключем в словаре изображений и выводим соответствующее
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let url = DemoURLs.NASA[identifier] {
                if let imageVC = segue.destination.contents as? ImageViewController { //Получаем заголовок из кнопки
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }

}

//Так как ситуация очень распространенная, когда Detail из SplitView оказывается в NavigationController
//Чтобы не писать код каждый раз проще поместить его в расширение для контроллера
//Получаем переменную с контентом которая равна содержимому контроллера, для большинства это будет self, но для навконтроллера это видимый контроллер
//а для табконтроллера это выбранная вкладка
extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else if let tabcon = self as? UITabBarController {
            return tabcon.selectedViewController ?? self
        } else {
            return self
        }
    }
}
