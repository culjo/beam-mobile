//
//  ApiClient.swift
//  trudata
//
//  Created by MAC on 1/10/19.
//  Copyright © 2019 trudata. All rights reserved.
//

import Alamofire
import RxSwift

enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}

class ApiClient {
    
    static func fetchProducts() -> Observable<Products> {
        return performRxRequest(ProductsEndpoint.fetch())
    }
    
    static func fetchUserProducts() -> Observable<UserProducts> {
        return performRxRequest(UserProductsEndpoint.fetch(userId: UserSessionManger.userId))
    }
    
    static func login(phone: String, uuid: String) -> Observable<UserResponse> {
        return performRxRequest(UsersEndpoint.login(phone: phone, uniqueId: uuid))
    }
    
    static func subcribeToProduct(productId: Int, userId: Int, myPrice: String) -> Observable<SubscriptionResponse> {
        return performRxRequest(ProductsEndpoint.addToWatchList(productId: productId, userId: userId, myPrice: myPrice))
    }
    
    static func saveFcmToken(userId: Int, fcmToken: String) -> Observable<ResponseUpdate> {
        return performRxRequest(UsersEndpoint.saveFcmToken(userId: userId, token: fcmToken))
    }
    
    
    
    // MARK: - The request functon to get results in an Observable
    private static func performRxRequest<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        
        // Create an Rxswift observable, which will be the one to call the request when subscribed to
        return Observable<T>.create {
            observer in
            // Trigger the HttpRequest using Alamofire
            let request =  AF.request(urlConvertible)
                //.validate() // matched 200..<300 & Content-Type matches the one set in the request header
                .responseDecodable { (response: DataResponse<T>) in
                    debugPrint(response)
                switch response.result {
                case .success(let value):
                    
                    print("===================== RESPONSE =====================")
                    debugPrint(value)
                    // Cool Everything worked.
                    observer.onNext(value)
                    observer.onCompleted()
                    
                case .failure(let error):
                    // Somthing went wront, so let's get the status code tight
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(ApiError.forbidden)
                    case 404:
                        observer.onError(ApiError.notFound)
                    case 409:
                        observer.onError(ApiError.conflict)
                    case 500:
                        observer.onError(ApiError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                    
                }
            }
            
            // Finally, we retunr a disposable to stop the request
            return Disposables.create {
                request.cancel()
                
            }
        }
        
    }
    
    
    //    static func getPosts(userId: Int) -> Observable<[PostDTO]> {
    //        return request(ApiRouter.getPosts(userId: userId))
    //    }
    
    // Note: this implementation uses the callback method
    /*static func login(email: String, password: String, completion: @escaping (Result<UserDTO>) -> Void) {
     AF.request(UserEndpoint.login(email: email, password: password))
     .responseDecodable { (response: DataResponse<UserDTO>) in
     completion(response.result)
     }
     
     }
     
     static func createUser(params: [String: String]) -> Observable<UserDTO> {
     return performRxRequest(UserEndpoint.register(params: params))// email: "", fullName: "", password: ""))
     }*/
    
    
}
