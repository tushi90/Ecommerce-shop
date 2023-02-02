


import UIKit

class ItemSelectVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var itemCountLbl: UILabel!
    @IBOutlet weak var sumOfSelectedItemPrice: UILabel!
    
    @IBOutlet weak var trashBtn: UIButton!
    @IBOutlet weak var moveTobusketBtn: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    var items = [[ProductsInfo]]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moveTobusketBtn.setTitle( "კალათაში გადასვლა >", for: .normal)
        itemCountLbl.text = "0"
        sumOfSelectedItemPrice.text = "0"
        
        configureTableview()
        getitem()
    }
    
    @IBAction func clearIteam(_ sender: UIButton) {
        clearItemInfo()
    }
    
    func getitem() {
        NetworkService.shared.getitem { [weak self] itemData in
            var userIDs = Set<String>()
            for item in itemData.products {
                userIDs.insert(item.category)
            }
            for userID in userIDs {
                let filtered = itemData.products.filter { $0.category == userID }
                self?.items.append(filtered)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func configureTableview() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func clearItemInfo () {
        itemCountLbl.text = "0"
        sumOfSelectedItemPrice.text = "0"
        
        for i in 0...tableView.numberOfSections-1 {
            
            for j in 0...tableView.numberOfRows(inSection: i)-1 {
                let current = items[i][j].chosenQuantity ?? 0
                if current > 0 {
                    items[i][j].stock -= current
                }
                
                if let cell = tableView.cellForRow(at: IndexPath(row: j, section: i)) as? TableViewCell {
                    cell.itemQuantityLbl.text = "0"
                    if current > 0 {
                        cell.itemQuantityLbl.text = String(items[i][j].stock)
                    }
                }
                
                items[i][j].chosenQuantity = 0
            }
        }
    }
}






