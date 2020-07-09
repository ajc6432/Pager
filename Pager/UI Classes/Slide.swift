import UIKit

class Slide: UIView, Loadable {

    @IBOutlet weak var imageView: UIImageView!

    var delegate: SlideDelegate?
    var image: UIImage?

    func setImage(to img: UIImage?) {
        image = img
        imageView.image = img
    }

    @IBAction func tapAction(_ sender: Any) {
        delegate?.didTapSlide(withImage: image)
    }
}
