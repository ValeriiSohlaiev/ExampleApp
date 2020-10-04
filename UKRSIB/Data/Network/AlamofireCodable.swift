//
//  AlamofireCodable.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 30.09.2020.
//

import Foundation
import Alamofire
import Models
import XMLParsing

extension DataRequest {

    private static func CodableObjectSerializer<T: Codable>( _ decoder: XMLDecoder) -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            return DataRequest.codableToObject(decoder: decoder, response: response, data: data)
        }
    }

    private static func codableToObject<T: Codable>(decoder: XMLDecoder, response: HTTPURLResponse?, data: Data?) -> Result<T> {
        let result = Request.serializeResponseData(response: response, data: data, error: nil)

        switch result {
        case .success(let data):
            do {
                let object = try decoder.decode(T.self, from: data)
                return .success(object)
            } catch let error {
                #if DEBUG
                print("\n ##### Error parse: please check codable \n \(response?.url?.absoluteString ?? "") \n \(error) \n")
                #endif
                let parseError = NSError(domain: "PARSE ERROR DATA",
                                         code: response?.statusCode ?? -1,
                                         userInfo: [NSLocalizedDescriptionKey: "Error parse data"])
                return .failure(parseError)
            }
        case .failure:
            let unknownError = NSError(domain: "UNKNOWN_ERROR",
                                       code: response?.statusCode ?? -1,
                                       userInfo: [NSLocalizedDescriptionKey: "UNKNOWN_ERROR"])
            return .failure(unknownError)
        }
    }

    /// returns: The request.
    @discardableResult
    public func responseCodable<T: Codable>(queue: DispatchQueue? = nil, decoder: XMLDecoder = XMLDecoder(),
                                            completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataRequest.CodableObjectSerializer(decoder), completionHandler: completionHandler)
    }

}
