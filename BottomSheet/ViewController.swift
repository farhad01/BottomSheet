//
//  ViewController.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/8/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showPressed(_ sender: UIButton) {
        let foo = UIStoryboard(name: "BottomSheetViewController", bundle: nil).instantiateInitialViewController() as! FooBottomSheetViewController
        foo.parallexDelegate = self
        let viewController = UINavigationController(rootViewController: foo)
        viewController.navigationBar.isTranslucent = false
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: false, completion: nil)
        
    }
    
}
extension ViewController: ParallexBackgroundProtocol {
    var frame: CGRect {
        return image.frame
    }
    
    func scrollDidChange(transform: CGAffineTransform) {
        image.transform = transform
    }
    
    
}
