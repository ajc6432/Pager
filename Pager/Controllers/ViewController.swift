import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redView: UIView!

    var sliderView: SliderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let images = [UIImage(named: "pup"), UIImage(named: "pup2"), UIImage(named: "pup3"), UIImage(named: "pup4")]
        sliderView = SliderView.loadFromNib()
        sliderView.setup(withImages: images, superView: redView) { [weak self] image in
            self?.performSegue(withIdentifier: "showDetail", sender: image)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            detailVC.img = sender as? UIImage
        }
    }
}
