//
//  File.swift
//  quizzz
//
//  Created by Сергеев on 17.12.2023.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()

    func getPackPreviews() async throws -> [PackPreviewDTO] {
        try await request(target: .getPackPreviews)
    }

    func getPack(with id: Int) async throws -> PackDTO {
        try await request(target: .getPack(id: id))
    }
}

private extension NetworkService {
    func request<T: Decodable>(target: QuizTarget) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            let urlPath = target.getPath()
            guard let url = URL(string: urlPath) else {
                continuation.resume(throwing: Errors.fakeURL)
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, respone, error in
                if let error = error {
                    continuation.resume(throwing: error)
                }

                guard let data = data else {
                    continuation.resume(throwing: Errors.noData)
                    return
                }
                do {
                    let packPreviews = try JSONDecoder().decode(T.self, from: data)
                    continuation.resume(returning: packPreviews)
                } catch {
                    continuation.resume(throwing: error)
                }
            }.resume()
        }
    }
}

extension NetworkService {
    enum Errors: Error {
        case fakeURL
        case noData
    }
}
