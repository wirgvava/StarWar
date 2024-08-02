//
//  FirestoreManager.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 09.07.24.
//

import FirebaseCore
import FirebaseFirestore

class FirestoreManager: ObservableObject {
    
    static let shared = FirestoreManager()
    
    var topScores = [TopScores]()
    let db = Firestore.firestore()
    let collection: CollectionReference
    
    init(){
       collection = db.collection("TopScores")
    }
  
    // Fetch Leaderboard list
    func getTopScores(completion: @escaping() -> ()) {
        collection.order(by: "score", descending: true).getDocuments { snapshot, error in
            if let error = error {
                print("ERROR at getting top scores: ", error)
                completion()
            } else if let snapshot = snapshot {
                for document in snapshot.documents {
                    self.topScores.append(
                        TopScores(name: "\(document.documentID)",
                                  score: document.data().values.first as? Int ?? 0))
                }
                completion()
            }
        }
    }
    
    // Add score to leaderboard
    func addTopScore(name: String, score: Int) {
        let data = ["score" : score]
        
        collection.document(name).setData(data) { error in
            if let error = error {
                print("ERROR at adding top score: ", error)
            } else {
                self.removeScoresAfterHundred()
            }
        }
    }
    
    func removeScoresAfterHundred(){
        collection.order(by: "score", descending: true).getDocuments { snapshot, error in
            if let error = error {
                print("ERROR at removing useless scores: ", error)
            } else if let snapshot = snapshot {
                let documents = snapshot.documents
                
                if documents.count > 100 {
                    let documentsToDelete = documents[100...]
                    
                    for document in documentsToDelete {
                        self.collection.document(document.documentID).delete { error in
                            if let error = error {
                                print("Error deleting document: \(error)")
                            }
                        }
                    }
                    
                    self.rewriteTopScores(documents: documents)
                }
            }
        }
    }
    
    func rewriteTopScores(documents: [QueryDocumentSnapshot]){
        let documentsToWrite = documents[0...99]
        self.topScores.removeAll()
        
        for document in documentsToWrite {
            self.topScores.append(
                TopScores(name: "\(document.documentID)",
                          score: document.data().values.first as? Int ?? 0))
        }
    }
}
