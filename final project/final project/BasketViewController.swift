

import UIKit

class BasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var basketTableView: UITableView!
    
    @IBOutlet weak var paymentPageLbl: UILabel!
    
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var feeLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    
    @IBOutlet weak var paymentBtn: UIButton!
    
    @IBOutlet weak var paymentPageView: UIView!
    
    var deliveryPrice = 50
    
    var moneyInBalance = 4000
    
    var productInBasket: [ProductsInfo] = []
    
    var basketClouser: (() -> Void)?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        deliveryLbl.text = String(deliveryPrice)
        paymentPageLbl.text = "გადახდის გვერდი"
        paymentBtn.tintColor = .white
        paymentBtn.setTitle("გ ა დ ა ხ დ ა", for: .normal)
        
        configurationBasketTableView()
        LastPrice()

    }
    
    func configurationBasketTableView() {
        self.basketTableView.delegate = self
        self.basketTableView.dataSource = self
    }
    
    func LastPrice() {
        var totalprice = 0
        for i in productInBasket {
            totalprice += i.price * i.chosenQuantity!
        }
        totalPriceLbl.text = String(totalprice)
        let feePrice = Double(totalprice) * 0.1
        feeLbl.text = String(feePrice)
        let total = Double(totalprice) + feePrice + Double(deliveryPrice)
        totalLbl.text = String(total)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productInBasket.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
        cell.itemImageInBasket.load(url: URL(string: productInBasket[indexPath.row].thumbnail)!)
        cell.itemTitleInBasketLbl.text = productInBasket[indexPath.row].title
        cell.itemCountInBasketLbl.text = String(productInBasket[indexPath.row].chosenQuantity!)
        cell.itemPriceInBasketLbl.text = String(productInBasket[indexPath.row].chosenQuantity! * productInBasket[indexPath.row].price)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    @IBAction func payedorNotBtn(_ sender: UIButton) {

        let lastcheckVC = storyboard!.instantiateViewController(withIdentifier: "PayedOrNotVC") as! PayedOrNotVC
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            self.present(lastcheckVC, animated: true)
            
            if  Double(self.moneyInBalance) >= Double(self.totalLbl.text!)! {
                lastcheckVC.payedImage.isHidden = false
                lastcheckVC.PayedLbl.isHidden = false
            } else {
                lastcheckVC.notPayedImage.isHidden = false
                lastcheckVC.notPayedLbl.isHidden = false
            }
        }
    }
}




