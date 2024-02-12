//
//  CustomButton.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/11/24.
//

import UIKit

class CustomButton: UIButton {
    enum ButtonState {
        case enable, disable
    }
    
    private var disabledColor: UIColor?
    private var enabledColor: UIColor? {
        didSet {
            backgroundColor = enabledColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                if let color = enabledColor {
                    self.backgroundColor = color
                }
            } else {
                if let color = disabledColor {
                    self.backgroundColor = color
                }
            }
        }
    }
    
    func setBackgroundColor(_ color: UIColor?, for state: ButtonState) {
        switch state {
        case .enable:
            enabledColor = color
        case .disable:
            disabledColor = color
        }
    }
}
