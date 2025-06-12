//
//  FirestoreServiceUtil.swift.swift
//  manu
//
//  Created by Erick Valdez on 4/10/25.
//

import FirebaseFirestore

enum FirestoreError: Error {
    case documentNotFound(String)
    case decodingError(path: String, underlying: Error)
    case authError(String)
}

protocol FirestoreServiceProtocol {
    func fetchDocument<T: Codable>(path: String) async throws -> T
    func fetchCollection<T: Codable>(path: String) async throws -> [T]
    
    func fetchDocument<T: Codable>(documentRef: DocumentReference) async throws -> T
    func fetchCollection<T: Codable>(collectionRef: CollectionReference) async throws -> [T]
}

class FirestoreService: FirestoreServiceProtocol {
    
    let firestore: Firestore
    
    init(firestore: Firestore = .firestore()) {
        self.firestore = firestore
    }
    
    func fetchDocument<T>(path: String) async throws -> T where T : Codable {
        let docRef = firestore.document(path)
        let snapshot = try await docRef.getDocument()
        guard let data = snapshot.data() else {
            throw FirestoreError.documentNotFound(path)
        }
        do {
            let dto = try snapshot.data(as: T.self)
            return dto
        } catch {
            throw FirestoreError.decodingError(path: path, underlying: error)
        }
    }
    
    func fetchCollection<T>(path: String) async throws -> [T] where T : Codable {
        let colRef = firestore.collection(path)
        let snapshot = try await colRef.getDocuments()
        return try snapshot.documents.map { doc in
            do {
                return try doc.data(as: T.self)
            } catch {
                throw FirestoreError.decodingError(path: path, underlying: error)
            }
        }
    }
    
    func fetchDocument<T>(documentRef: DocumentReference) async throws -> T where T : Decodable, T : Encodable {
        let snapshot = try await documentRef.getDocument()
        guard let _ = snapshot.data() else {
            throw FirestoreError.documentNotFound(documentRef.path)
        }
        do {
            return try snapshot.data(as: T.self)
        } catch {
            throw FirestoreError.decodingError(path: documentRef.path, underlying: error)
        }
    }
    
    func fetchCollection<T>(collectionRef: CollectionReference) async throws -> [T] where T : Decodable, T : Encodable {
        let snapshot = try await collectionRef.getDocuments()
        return try snapshot.documents.map { doc in
            do {
                return try doc.data(as: T.self)
            } catch {
                throw FirestoreError.decodingError(path: doc.reference.path, underlying: error)
            }
        }
    }
    
}
