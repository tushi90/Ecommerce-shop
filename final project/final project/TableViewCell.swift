


import UIKit
//protocol ItemActionDelegate: AnyObject {
//    func addItemQuantity(for cell: TableViewCell)
//    func minusItemQuantity(for cell: TableViewCell)
//
//}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var stockCountLbl: UILabel!
    @IBOutlet weak var ItemPriceLbl: UILabel!
    
    @IBOutlet weak var itemQuantityLbl: UILabel!
        
    var quantityClouser: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemQuantityLbl.text = "0"
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func minusQuantityItem(_ sender: UIButton) {
        let numerProduct = Int(itemQuantityLbl.text!)!
        if numerProduct != 0 {
            itemQuantityLbl.text = String(numerProduct - 1)
            quantityClouser!(false)
        }
    }
    
    @IBAction func addQuantityItem(_ sender: UIButton) {
        let numerProduct = Int(itemQuantityLbl.text!)!
        itemQuantityLbl.text = String(numerProduct + 1)
        quantityClouser!(true)
    }
}
