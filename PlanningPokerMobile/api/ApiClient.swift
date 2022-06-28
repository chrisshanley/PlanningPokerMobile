//
//  ApiClient.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import Foundation
class ApiClient {
    
    enum Routes: String {
        case login = "/api-public/v1/accounts/login"
        case quickGame = "/api-public/v1/games/quick_game"
        case createGame = "/api/v1/games"
        case joinGame = "/api-public/v1/games/join/:code"
    }
    let host: String
    let session = URLSession.shared
    
    init(host: String) {
        self.host = host
    }
    
    func login(username: String, password: String) async throws -> LoginResponse {
        let url = URL(string: self.host + Routes.login.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(LoginRequest(email: username, password: password))
        let (data, _) = try await session.data(for: request, delegate: nil)
        let debug = String(data: data, encoding: String.Encoding.utf8)
        print("response: \(debug)")
        return try JSONDecoder().decode(LoginResponse.self, from: data)
    }
    
    func quickGame(ownerName: String, gameName: String) async throws -> QuickGameResponse {
        let url = URL(string: self.host + Routes.quickGame.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(QuickGameRequest(name: gameName, ownerName: ownerName))
        let (data, _) = try await session.data(for: request, delegate: nil)
        let debug = String(data: data, encoding: String.Encoding.utf8)
        print("response: \(debug)")
        return try JSONDecoder().decode(QuickGameResponse.self, from: data)
    }
    
    func joinGame(displayName: String, gameCode: String) async throws -> QuickGameResponse {
        let url = URL(string: self.host + Routes.joinGame.rawValue.replacingOccurrences(of: ":code", with: gameCode))!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(JoinGameRequest(displayName: displayName))
        let (data, _) = try await session.data(for: request, delegate: nil)
        let debug = String(data: data, encoding: String.Encoding.utf8)
        print("response: \(debug)")
        return try JSONDecoder().decode(QuickGameResponse.self, from: data)
    }
    
    func createGame(token: String, name: String, teamKey: String? = nil) async throws -> Game {
        let url = URL(string: self.host + Routes.createGame.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONEncoder().encode(CreateGameRequest(name: name, teamKey: teamKey))
        let (data, _) = try await session.data(for: request, delegate: nil)
        let debug = String(data: data, encoding: String.Encoding.utf8)
        print("response: \(debug)")
        return try JSONDecoder().decode(Game.self, from: data)
    }
}

class AuthorizedApiClient {
    
    enum Routes: String {
        case putItem = "/api/v1/games/:key/items"
        case putVote = "/api/v1/games/:key/item/:itemKey/vote"
    }
    
    let host: String
    private(set) var token: String
    let session = URLSession.shared
    
    init(host: String, token: String) {
        self.host = host
        self.token = token
    }
   
    func putItem(gameKey: String, title: String, notes: String?, estimate: Int?, itemKey: String?) async throws -> PutGameItemResponse {
        let url = URL(string: self.host + Routes.putItem.rawValue.replacingOccurrences(of: ":key", with: gameKey))!
        var request = self.request(method: "PUT", url: url)
        request.httpBody = try JSONEncoder().encode(PutGameItemRequest(title: title, notes: notes, estimate: estimate, itemKey: itemKey))
        let (data, response) = try await session.data(for: request, delegate: nil)
        print("http response: \(response)")
        let debug = String(data: data, encoding: String.Encoding.utf8)
        print("response: \(debug)")
        return try JSONDecoder().decode(PutGameItemResponse.self, from: data)
    }
    
    func vote(gameKey: String, itemKey: String, estimate: Int) async throws -> Game {
        let url = URL(string: self.host + Routes.putVote.rawValue.replacingOccurrences(of: ":key", with: gameKey).replacingOccurrences(of: ":itemKey", with: itemKey))!
        var request = self.request(method: "PUT", url: url)
        request.httpBody = try JSONEncoder().encode(VoteRequest(estimate: estimate))
        let (data, response) = try await session.data(for: request, delegate: nil)
        print("http response: \(response)")
        let debug = String(data: data, encoding: String.Encoding.utf8)
        print("data: \(debug)")
        return try JSONDecoder().decode(Game.self, from: data)
    }
    
    private func request(method: String, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
