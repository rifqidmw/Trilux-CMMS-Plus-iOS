//
//  ApiManager.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import Alamofire
import Combine

enum ErrorHandler: Error {
    case failedParsing
    case unknownError
    case dataEmpty
    case unauthorized
}

class ApiManager {
    
    private static let session: Session = {
        let evaluator: [String: ServerTrustEvaluating] = [
            "dev.triluxcmms.com": DisabledTrustEvaluator(),
            "triluxcmms.com": DisabledTrustEvaluator(),
            "trilux.id": DisabledTrustEvaluator()
        ]
        let manager = ServerTrustManager(evaluators: evaluator)
        let session = Session(serverTrustManager: manager)
        return session
    }()
    
    func requestApiPublisher<T: Codable>(_ endpoint: Endpoint, timeout: TimeInterval = 60) -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            Task {
                do {
                    AppLogger.log("CMMS-HEADER: \(endpoint.header)", logType: .kNetworkRequest)
                    AppLogger.log("CMMS-URL: \(endpoint.method().rawValue) => \(endpoint.urlString())", logType: .kNetworkRequest)
                    AppLogger.log("CMMS-PARAMS: \(endpoint.parameter ?? [:])", logType: .kNetworkRequest)
                    
                    let result: T = try await withUnsafeThrowingContinuation({ continuation in
                        ApiManager.session.request(
                            endpoint.urlString(),
                            method: endpoint.method(),
                            parameters: endpoint.parameter,
                            encoding: JSONEncoding.default,
                            headers: endpoint.header,
                            interceptor: nil,
                            requestModifier: { $0.timeoutInterval = timeout })
                        .responseData(
                            queue: .main,
                            dataPreprocessor: DataResponseSerializer.defaultDataPreprocessor,
                            emptyResponseCodes: [200, 401],
                            emptyRequestMethods: DataResponseSerializer.defaultEmptyRequestMethods) { response in
                                if let error = response.error {
                                    AppLogger.log(error, logType: .kNetworkResponseError)
                                    continuation.resume(throwing: error)
                                } else {
                                    guard let urlResponse = response.response else {
                                        AppLogger.log("invalid urlResponse", logType: .kNetworkResponseError)
                                        continuation.resume(throwing: ErrorHandler.unknownError)
                                        return
                                    }
                                    switch urlResponse.statusCode {
                                    case 401:
                                        AppLogger.log("Unauthorized", logType: .kNetworkResponseError)
                                        continuation.resume(throwing: ErrorHandler.unauthorized)
                                    default:
                                        if let data = response.data {
                                            do {
                                                let decoded = try JSONDecoder().decode(T.self, from: data)
                                                AppLogger.log(decoded, logType: .kNetworkResponseSuccess)
                                                continuation.resume(returning: decoded)
                                            } catch {
                                                AppLogger.log(error, logType: .kNetworkResponseError)
                                                continuation.resume(throwing: error)
                                            }
                                        } else {
                                            continuation.resume(throwing: ErrorHandler.unknownError)
                                        }
                                    }
                                }
                            }
                    })
                    
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
