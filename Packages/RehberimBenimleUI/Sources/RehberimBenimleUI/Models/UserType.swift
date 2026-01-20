//
//  UserType.swift
//  RehberimBenimleUI
//
//  Created by Okan Orkun on 19.01.2026.
//

public enum UserType: String, CaseIterable, AppDropDownItem {
    case notSelected = "Seçin"
    case student = "Öğrenci"
    case instructor = "Eğitmen"
    
    public var itemTitle: String {
        rawValue
    }
    
    public var isValid: Bool {
        self != .notSelected
    }
}
