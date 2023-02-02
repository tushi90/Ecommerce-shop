

import Foundation
import UIKit

class ProductList: Codable {
    var products: [ProductsInfo]
    
    init(products: [ProductsInfo]) {
        self.products = products
    }
}

class ProductsInfo: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    var stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    var chosenQuantity: Int?
    
    init (id: Int, title: String, description: String, price: Int, discountPercentage: Double, rating: Double, stock: Int, brand: String, category: String, thumbnail: String) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.chosenQuantity = 0
    }
}



