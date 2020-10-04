//
//  NetworkManager.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 30.09.2020.
//

import Foundation
import Alamofire

public final class NetworkManager {

    public static let shared = NetworkManager()

    public let sessionManager: SessionManager = {

        let headers = SessionManager.defaultHTTPHeaders

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.httpAdditionalHeaders = headers

        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "bank.gov.ua": .pinPublicKeys(
                publicKeys: ServerTrustPolicy.publicKeys(),
                validateCertificateChain: true,
                validateHost: true)
        ]

        let sessionManager = SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(
                policies: serverTrustPolicies
            )
        )

        return sessionManager
    }()

}
