

import Foundation
import UIKit

class NetworkService {
    
    static var shared = NetworkService()
    
    func getitem(completion: @escaping (ProductList)->()) {
        let url = URL(string: "https://dummyjson.com/products")!
        let urlReq = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlReq) { data, response, error in
            print(Thread.current.isMainThread)
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("no response")
                return
            }
            
            guard (200...300).contains(response.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            do {
                let itemList = try JSONDecoder().decode(ProductList.self, from: data)
                
                DispatchQueue.main.async {
                    completion(itemList)
                }
            } catch {
                print("error")
            }
        } .resume()
    }
}

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
