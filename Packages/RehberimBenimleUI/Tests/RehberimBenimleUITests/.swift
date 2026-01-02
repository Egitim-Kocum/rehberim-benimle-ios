//
//  LoadingStateTests.swift
//  RehberimBenimleUI
//
//  Created by Okan Orkun on 31.12.2025.
//

import Testing
@testable import RehberimBenimleUI

struct LoadingStateTests {

    @Test
    func test_LoadingState_idleState() {
        let state: LoadingState = .idle
        if case .idle = state {
            #expect(true)
        } else {
            #expect(false)
        }
    }

    @Test
    func loadingState() {
        let state: LoadingState = .loading
        if case .loading = state {
            #expect(true)
        } else {
            #expect(false)
        }
    }

    @Test
    func successState() {
        let state: LoadingState = .success
        if case .success = state {
            #expect(true)
        } else {
            #expect(false)
        }
    }

    @Test
    func errorStateContainsMessage() {
        let message = "Network error"
        let state: LoadingState = .error(message)

        if case let .error(msg) = state {
            #expect(msg == message)
        } else {
            #expect(false)
        }
    }
}
