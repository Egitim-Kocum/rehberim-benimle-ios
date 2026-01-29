//
//  BaseViewProtocol.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 25.12.2025.
//

@MainActor
public protocol BaseViewProtocol: AnyObject {
    func render(state: LoadingState)
}
