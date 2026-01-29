//
//  UserType.swift
//  RehberimBenimleUI
//
//  Created by Okan Orkun on 19.01.2026.
//

public enum UserType: CaseIterable, AppSegmentedItem {
    case student
    case instructor
    
    public var title: String {
        switch self {
        case .student: return "Öğrenci"
        case .instructor: return "Eğitmen"
        }
    }
}
