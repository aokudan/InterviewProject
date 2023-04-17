//
//  ViewController+SubView.swift
//  InterViewProject
//
//  Created by Abdullah Okudan on 18.03.2022.
//

/**
    https://medium.com/@code-in-swift/using-generics-to-simplify-subclassing-uiviewcontrollers-view-860c90852e27
 */
import UIKit

class ViewController<UI:UIView>: UIViewController {

    let ui = UI(frame: UIScreen.main.bounds)
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    //https://codeinswift.io/how-to-prevent-xcode-asking-for-required-initializer-init-coder-in-every-subclass-of-uiviews-c67054284fc2
    @available(*, unavailable, message: "Nibs are unsuported")
    public required init?(coder: NSCoder) {
        fatalError("Nibs are unsuported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = ui
    }

}
