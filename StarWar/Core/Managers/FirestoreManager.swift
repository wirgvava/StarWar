//
//  FirestoreManager.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 09.07.24.
//

import FirebaseCore
import FirebaseFirestore

class FirestoreManager: NSObject {
        
    static var topScores = [TopScores]()
    static let db = Firestore.firestore()
    static let collection = db.collection("TopScores")
  
    // Fetch Leaderboard list
    static func getTopScores() {
        collection.order(by: "score", descending: true).getDocuments { snapshot, error in
            if let error = error {
                print("ERROR at getting top scores: ", error)
            } else if let snapshot = snapshot {
                for document in snapshot.documents {
                    FirestoreManager.topScores.append(
                        TopScores(name: "\(document.documentID)",
                                  score: document.data().values.first as? Int ?? 0))
                }
            }
        }
    }
    
    // Add score to leaderboard
    static func addTopScore(name: String, score: Int) {
        let data = ["score" : score]
        
        collection.document(name).setData(data) { error in
            if let error = error {
                print("ERROR at adding top score: ", error)
            } else {
                removeScoresAfterHundred()
            }
        }
    }
    
    static func removeScoresAfterHundred(){
        collection.order(by: "score", descending: true).getDocuments { snapshot, error in
            if let error = error {
                print("ERROR at removing useless scores: ", error)
            } else if let snapshot = snapshot {
                let documents = snapshot.documents
                
                if documents.count > 100 {
                    let documentsToDelete = documents[100...]
                    
                    for document in documentsToDelete {
                        collection.document(document.documentID).delete { error in
                            if let error = error {
                                print("Error deleting document: \(error)")
                            }
                        }
                    }
                    
                    rewriteTopScores(documents: documents)
                }
            }
        }
    }
    
    static func rewriteTopScores(documents: [QueryDocumentSnapshot]){
        let documentsToWrite = documents[0...99]
        FirestoreManager.topScores.removeAll()
        
        for document in documentsToWrite {
            FirestoreManager.topScores.append(
                TopScores(name: "\(document.documentID)",
                          score: document.data().values.first as? Int ?? 0))
        }
    }
}
