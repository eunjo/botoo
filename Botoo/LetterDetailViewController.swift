//
//  LetterDetailViewController.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 20..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit

class LetterDetailViewController: UIViewController {
    
    @IBOutlet var textField: UITextView!
    var letterBody = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = letterBody
    }
}
