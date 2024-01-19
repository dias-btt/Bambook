//
//  FeedInteractor.swift
//  Bambook
//
//  Created by Диас Сайынов on 11.01.2024.
//

import Foundation
import Alamofire

final class FeedInteractor {
    weak var presenter: FeedPresenterProtocol?
    // Add properties for data manager, networking, etc.

    init(presenter: FeedPresenterProtocol? = nil) {
        self.presenter = presenter
    }
}

extension FeedInteractor: FeedInteractorProtocol{
    
    func parseBooks(jsonData: Data) -> [BookData]? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            guard let jsonDict = jsonObject as? [String: Any],
                  let items = jsonDict["items"] as? [[String: Any]] else {
                return nil
            }

            var books = [BookData]()

            for item in items {
                if let volumeInfo = item["volumeInfo"] as? [String: Any],
                   let title = volumeInfo["title"] as? String,
                   let authors = volumeInfo["authors"] as? [String],
                   let averageRating = volumeInfo["averageRating"] as? Double,
                   let ratingsCount = volumeInfo["ratingsCount"] as? Int,
                   let imageLinksDict = volumeInfo["imageLinks"] as? [String: String],
                   let thumbnailString = imageLinksDict["thumbnail"],
                   let description = volumeInfo["description"] as? String{

                    let book = BookData(title: title, authors: authors, averageRating: averageRating, ratingsCount: ratingsCount, thumbnail: thumbnailString, description: description)
                    books.append(book)
                }
            }

            return books
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    }

    
    func fetchFeedData(completion: @escaping (Data?) -> Void) {
            AF.request("https://www.googleapis.com/books/v1/volumes?q=harry+potter").responseData { response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print("Error fetching data: \(error)")
                    completion(nil)
                }
            }
        }
}
