

import Foundation
import UIKit

extension ItemSelectVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let view = UIView()
        label.frame = CGRect(x: 20 , y: -10, width: 300, height: 30)
        label.text = "\(items[section].first!.category)"
        label.backgroundColor = .white
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let arrayForShow = items[indexPath.section]
        let currentItem = arrayForShow[indexPath.row]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.itemImage.load(url: URL(string: currentItem.thumbnail)!)
        cell.brandLbl.text = currentItem.brand
        cell.stockCountLbl.text = "stock: \(String(currentItem.stock))"
        cell.ItemPriceLbl.text = "price: \(String(currentItem.price))"
        cell.itemQuantityLbl.text = String(currentItem.chosenQuantity ?? 0)
        
        cell.quantityClouser = { added in

            let currentCount = Int(self.itemCountLbl.text!)!
            let currentPrice = Int(self.sumOfSelectedItemPrice.text!)!

            if added {
                self.itemCountLbl.text = String(currentCount + 1)
                self.sumOfSelectedItemPrice.text = String(currentPrice + currentItem.price)
                let current = currentItem.chosenQuantity ?? 0
                currentItem.chosenQuantity = current + 1

            } else {
                self.itemCountLbl.text = String(currentCount == 0 ? 0 : currentCount - 1)
                self.sumOfSelectedItemPrice.text = String(currentPrice - currentItem.price)
                let current = currentItem.chosenQuantity ?? 0
                if current != 0 {
                    currentItem.chosenQuantity = current - 1
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    @IBAction func moveToBasketButton(_ sender: UIButton) {
        
        var MyProducts: [ProductsInfo] = []
        
        for i in 0...tableView.numberOfSections-1 {
            
            for j in 0...tableView.numberOfRows(inSection: i)-1 {
                let current = items[i][j].chosenQuantity ?? 0
                if current > 0 {
                    MyProducts.append(items[i][j])
                }
            }
        }
        
        if !MyProducts.isEmpty {
            
            let basketVC = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasketViewController")) as! BasketViewController?
            basketVC?.productInBasket.append(contentsOf: MyProducts)
//            basketVC?.basketClouser = {self.}
            self.navigationController?.pushViewController(basketVC!, animated: false)
            
        } else {
            let alert = UIAlertController(title: "შეცდომა", message: "გთხოვთ აირჩიოთ პროდუქტი", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}
