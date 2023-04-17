//
//  DynamicLabel.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 15.03.2022.
//

import Foundation

class DynamicLabel: Label {
    
    private var dynamicTheme: LabelTheme?
    override var theme: LabelTheme {
        return dynamicTheme ?? super.theme
    }
    
    func update(theme: LabelTheme) {
        self.dynamicTheme = theme
        update()
    }
    
}
