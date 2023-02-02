
import UIKit

class PayedOrNotVC: UIViewController {
    
    @IBOutlet weak var payedImage: UIImageView!
    @IBOutlet weak var PayedLbl: UILabel!
    
    @IBOutlet weak var notPayedImage: UIImageView!
    @IBOutlet weak var notPayedLbl: UILabel!
    
    var action: (()-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        payedImage.isHidden = true
        PayedLbl.isHidden = true
        
        notPayedImage.isHidden = true
        notPayedLbl.isHidden = true
        
        PayedLbl.text = "გადახდა წარმატებით შესრულდა"
        notPayedLbl.text = "სამწუხაროდ გადახდა ვერ მოხერხდა სცადეთ თავიდან"
        
    }
    
    @IBAction func goBackPageBtn(_ sender: UIButton) {
        if notPayedImage.isHidden == false {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

