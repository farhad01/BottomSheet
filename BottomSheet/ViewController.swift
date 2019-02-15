//
//  ViewController.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/8/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showPressed(_ sender: UIButton) {
        let viewController = FooBottomSheetViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: true, completion: nil)
        
    }
    
}

