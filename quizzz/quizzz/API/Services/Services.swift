//
//  File.swift
//  quizzz
//
//  Created by Сергеев on 17.12.2023.
//

import Foundation
final class NetworkService {
    static let shared = NetworkService()

    func getPackPreviews() async -> PackPreviewDTO? {
        let urlPath = QuizTarget.getPackPreviews.getPath()
        guard let url = URL(string: urlPath) else { return nil }

        URLSession.shared.dataTask(with: url) { data, respone, error in
            if let error = error{
                print(error)
                return
            }

            guard let data = data else { return }
            do {
                let CategoriesOfQuestions = try JSONDecoder().decode([PackPreviewDTO].self, from: data)
                complition(CategoriesOfQuestions)
            } catch {
                print(error)
            }
        }.resume()
    }

    func connectionDidFinishLoading(complition: @escaping ([PackPreviewDTO]) -> Void) {
        let urlString = ""
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, respone, error in
            if let error = error{
                print(error)
                return
            }
            
            guard let data = data else { return }
            do {
                let CategoriesOfQuestions = try JSONDecoder().decode([PackPreviewDTO].self, from: data)
                complition(CategoriesOfQuestions)
            } catch {
                print(error)
            }
        }.resume()
    }

    func test() {
        connectionDidFinishLoading { questions in
            print(questions)
        }
    }
}
