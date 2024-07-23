//
//  GameCenterManager.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 12.07.24.
//

import GameKit

class GameCenterManager: NSObject {
    
    static let shared = GameCenterManager()
    let matchName = "StarWar-SavedData"
    
    //  MARK: - Authenticate
    func authenticate(completion: @escaping(Bool) -> ()) {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController?.present(viewController, animated: true)
                completion(true)
                return
            }
            if let error = error {
                print("Error at authenticate Game Center: ", error)
                completion(false)
                return
            }
        }
    }
    
    //  MARK: - Save data
    func save(data: GameData) {
        guard GKLocalPlayer.local.isAuthenticated else {
            print("Player is not authenticated.")
            return
        }
        
        // Encode game data
        guard let encodedGameData = encode(gameData: data) else {
            print("Failed to encode game data.")
            return
        }
        
        Task {
            do {
                try await GKLocalPlayer.local.saveGameData(encodedGameData, withName: matchName)
                print("Game data saved successfully.")
            } catch {
                print("Error: \(error.localizedDescription).")
            }
        }
    }
    
    //  MARK: - Fetch Data
    func fetchSavedData(completion: @escaping (GameData?) -> Void) {
        guard GKLocalPlayer.local.isAuthenticated else {
            print("Player is not authenticated.")
            completion(nil)
            return
        }
        
        GKLocalPlayer.local.fetchSavedGames { savedGames, error in
            if let error = error {
                print("Error fetching saved games: \(error.localizedDescription).")
                completion(nil)
                return
            }
            
            guard let savedGames = savedGames else {
                print("No saved games found.")
                completion(nil)
                return
            }
            
            guard let savedGame = savedGames.first(where: { $0.name == self.matchName }) else {
                print("No saved game found with the name \(self.matchName).")
                completion(nil)
                return
            }
            
            self.loadGameData(savedGame: savedGame, completion: completion)
        }
    }
    
    private func loadGameData(savedGame: GKSavedGame, completion: @escaping (GameData?) -> Void) {
        savedGame.loadData { data, error in
            if let error = error {
                print("Error loading saved game data: \(error.localizedDescription).")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data found in saved game.")
                completion(nil)
                return
            }
            
            let gameData = self.decode(data: data)
            
            print("FETCHED DATA: ", data)
            completion(gameData)
        }
    }
    
    // MARK: - Update Game Center data
    func updateData() {
        let appStorageManager = AppStorageManager.shared
        GameCenterManager.shared.save(
            data: GameData(userHighScore: appStorageManager.userHighScore,
                           money: appStorageManager.money,
                           unlockedShips: appStorageManager.unlockedShips)
        )
    }
    
    //  MARK: - Encode/Decode
    private func encode(gameData: GameData) -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(gameData)
    }
    
    // Function to decode the game data
    private func decode(data: Data) -> GameData? {
        let decoder = JSONDecoder()
        return try? decoder.decode(GameData.self, from: data)
    }
}
