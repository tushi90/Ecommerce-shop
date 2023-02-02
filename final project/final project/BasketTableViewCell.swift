

import UIKit

class BasketTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageInBasket: UIImageView!
    
    @IBOutlet weak var itemTitleInBasketLbl: UILabel!
    @IBOutlet weak var itemCountInBasketLbl: UILabel!
    @IBOutlet weak var itemPriceInBasketLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
