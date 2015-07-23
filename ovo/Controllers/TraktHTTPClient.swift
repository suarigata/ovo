//
//  TraktHTTPClient.swift
//  ovo
//
//  Created by iOS on 7/22/15.
//
//

import Foundation
import Alamofire
import Result
import TraktModels

class TraktHTTPClient {
    private lazy var manager: Alamofire.Manager = {
        let configuration: NSURLSessionConfiguration = {
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"] = "gzip"
            headers["Content-Type"] = "application/json"
            headers["trakt-api-version"] = "2"
            headers["trakt-api-key"] = "593a1401e4efb8ea9c36335f10d6c97342ac05137d70e108ed54497ef16c969d"
            configuration.HTTPAdditionalHeaders = headers
            return configuration
        }()
        return Manager(configuration: configuration)
    }()
    
    private enum Router: URLRequestConvertible {
        static let baseURLString = "https://api-v2launch.trakt.tv/"
        
        case Show(String)
        case Episode(String, Int, Int)
        case PopularShows()
        case Seasons(String)
        case Episodes(String, Int)
        
        // MARK: URLRequestConvertible
        var URLRequest: NSURLRequest {
            let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
                switch self {
                case .Show(let id):
                    return ("shows/\(id)", ["extended": "images,full"], .GET)
                case .Episode(let id, let season, let number):
                    return ("shows/\(id)/seasons/\(season)/episodes/\(number)", ["extended": "images,full"], .GET)
                case .PopularShows():
                    return ("shows/popular", ["extended": "images,full"], .GET)
                case .Seasons(let id):
                    return ("shows/\(id)/seasons", ["extended": "images,full"], .GET)
                case .Episodes(let id, let season):
                    return ("shows/\(id)/seasons/\(season)", ["extended": "images,full"], .GET)
                }
                }()
            
            let URL = NSURL(string: Router.baseURLString)!
            let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            URLRequest.HTTPMethod = method.rawValue
            
            let encoding = Alamofire.ParameterEncoding.URL
            
            return encoding.encode(URLRequest, parameters: parameters).0
        }
    }
    
    func getPopularShows(completion: ((Result<[Show], NSError?>) -> Void)?){
        
        getJSONElements(Router.PopularShows(), completion: completion)
    }
    
    func getSeasons(showId: String, completion: ((Result<[Season], NSError?>) -> Void)?){
        
        getJSONElements(Router.Seasons(showId), completion: completion)
    }
    
    func getEpisodes(showId: String, season: Int, completion: ((Result<[Episode], NSError?>) -> Void)?){
        
        getJSONElements(Router.Episodes(showId,season), completion: completion)
    }
    
    func getShow(id: String, completion: ((Result<Show, NSError?>) -> Void)?) {
        
        getJSONElement(Router.Show(id), completion: completion)
    }
    
    func getEpisode(showId: String, season: Int, episodeNumber: Int, completion: ((Result<Episode, NSError?>) -> Void)?){
        
        getJSONElement(Router.Episode(showId, season, episodeNumber), completion: completion)
    }
    
    private func getJSONElement<T: JSONDecodable>(router: Router, completion: ((Result<T, NSError?>) -> Void)?) {
        manager.request(router).validate().responseJSON { (_, _, responseObject, error)  in
            if let json = responseObject as? NSDictionary {
                if let value = T.decode(json) {
                    completion?(Result.success(value))
                }
                else{
                    completion?(Result.failure(nil))
                }
            }
            else{
                    completion?(Result.failure(error))
            }
        }
    }
    
    private func getJSONElements<T: JSONDecodable>(router: Router, completion: ((Result<[T], NSError?>) -> Void)?) {
        manager.request(router).validate().responseJSON { (_, _, responseObject, error)  in
            if let array = responseObject as? NSArray{
                var ret : [T] = []
                for i in array{
                    if let json = i as? NSDictionary, value = T.decode(json){
                        ret.append(value)
                    }
                    else{
                        completion?(Result.failure(nil))
                    }
                }
                completion?(Result.success(ret))
            }
            else{
                completion?(Result.failure(error))
            }
        }
    }
}