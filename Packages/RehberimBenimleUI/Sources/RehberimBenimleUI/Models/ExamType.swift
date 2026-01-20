//
//  ExamType.swift
//  RehberimBenimleUI
//
//  Created by Okan Orkun on 19.01.2026.
//

public enum ExamType: String, CaseIterable, AppDropDownItem {
    case notSelected = "Seçin"
    case tyt = "TYT"
    case ayt = "AYT"
    case yks = "TYT/AYT"
    case lgs = "LGS"
    
    public var itemTitle: String {
        rawValue
    }
    
    public var isValid: Bool {
        self != .notSelected
    }
}
