//
//  Store.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/7/22.
//

import Foundation

struct AppState {
    var credential: Credential
}

enum Action {
    case loggedIn(Any?)
}

protocol Reducer {
    func update(_ appState: inout AppState, _ action: Action)
}

class ReducerImpl: Reducer {
    func update(_ appState: inout AppState, _ action: Action) {
        switch action {
        case .loggedIn(let data):
            guard let credential = data as? Credential else {
                return
            }
            appState.credential = credential
        }
    }
}

protocol Store {
    var reducer: Reducer { get set }
    var appState: AppState { get set }
    func dispatch(_ action: Action)
}

class StoreImpl: ObservableObject, Store {
    let shared = StoreImpl(appState: AppState(credential: Credential(email: "", password: "")), reducer: ReducerImpl())
    var reducer: Reducer
    @Published var appState: AppState
    
    init(appState: AppState, reducer: Reducer) {
        self.appState = appState
        self.reducer = reducer
    }
    
    func dispatch(_ action: Action) {
        self.reducer.update(&appState, action)
    }
}
