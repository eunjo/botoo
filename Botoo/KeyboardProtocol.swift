//
//  KeyboardProtocol.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 4..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import Foundation

protocol KeyboardProtocol {
    func keyboardWillShow(notification:NSNotification)
    func keyboardWillHide(notification:NSNotification)
    func adjustingHeight(show:Bool, notification:NSNotification)
}
