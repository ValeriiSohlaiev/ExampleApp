//
//  Exchange.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 30.09.2020.
//

import Models
import Alamofire
import EndpointAPI

class ExchangeApi {
    
    static func currency(completion: @escaping (_ success: Bool, _ accounts: ExchangeModel?, _ error: Error?) -> Void) {
        let url = Api.baseUrl + Api.NBUStatService.URL
        
        NetworkManager.shared.sessionManager.request(url, method: .get)
            .validate()
            .responseCodable { (response: DataResponse<ExchangeModel>) in
                switch response.result {
                case .success:
                    if let dataList = response.result.value?.currency {
                        dataList.forEach {
                            guard let r030 = $0.r030, let txt = $0.txt, let cc = $0.cc,
                                  let exchangedate = $0.exchangedate, let rate = $0.rate else { return }
                            DB.storage?.addCurrency(r030: r030, txt: txt, cc: cc)
                            DB.storage?.addExchange(r030: r030, exchangedate: exchangedate, rate: rate)
                        }
                    }
                    completion(true, response.result.value, nil)
                case .failure(let error):
                    completion(false, nil, error)
                }
            }
    }
    
}
