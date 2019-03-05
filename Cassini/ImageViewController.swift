//
//  ImageViewController.swift
//  Cassini
//
//  Created by Maksym Logvin on 3/5/19.
//  Copyright © 2019 Maksym Logvin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    //Модель нашего проекта - файл класса URL может быть локальным или в интернете
    //Если кто-то попытается установить переменную извне мы должны скинуть ее в nil а затем выбрать новое изображение при помощи функции fetchImage
    //Так как я не хочу запускать выборку изображения для загрузки его в наш вью если мы еще не находимся на экране, то делаем проверку есть ли у нашего вью свойство window которое не равно nil
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
            fetchImage()
            }
        }
    }
    
    //Как только система подцепит наш аутлет во время загрузки мы просим добавить ему наш вью в качестве сабвью скроллвью
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25 //Минимальный масштаб
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    //Создаем вью прямо в коде вместо интерфейс билдера
    var imageView = UIImageView()
    
    //Вычисляемая переменная которая берет значение из загруженного изображения и меняет контентную область скроллвью если это новое изображение с новыми размерами
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    //Метод загрузки изображения из переменной
    private func fetchImage() {
        if let url = imageURL {
            let urlContents = try? Data(contentsOf: url) //Так как этот инициализатор типа "сумка битов" Data может выбрасывать ошибки мы ставим ключевое слово try
            if let imageData = urlContents {
                image = UIImage (data: imageData) // После того как предыдущий метод дал нашему сабвью размер растянув его под изображение и у него появился frame мы можем установить размер контентной области скроллвью
            }
        }
    }
    
    //Без реализации этого стандартного метода наше изображение не сможет масштабироваться
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //Если в наше вью так и не было загружено изображение загружаем его здесь
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = DemoURLs.stanford
        }
    }
    
}
