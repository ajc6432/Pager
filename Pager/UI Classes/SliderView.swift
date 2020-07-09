import UIKit

protocol SlideDelegate {
    func didTapSlide(withImage img: UIImage?)
}

class SliderView: UIView, UIScrollViewDelegate, Loadable, SlideDelegate {
    static var reuseID: String {
        return String(describing: self)
    }

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    private var slides: [Slide] = []
    private var tapHandler: ((UIImage?) -> Void)?

    func setup(withImages images: [UIImage?], superView: UIView, tapHandler: ((UIImage?) -> Void)?) {
        frame = CGRect(x: 0, y: 0, width: superView.frame.width, height: superView.frame.height)

        self.tapHandler = tapHandler

        superView.addSubview(self)
        generateSlides(fromImages: images)

        setupScrollView(superView: superView)

        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
    }

    private func generateSlides(fromImages images: [UIImage?]) {
        for image in images {
            let slide = Slide.loadFromNib()
            slide.setImage(to: image)
            slide.delegate = self
            slides.append(slide)
        }
    }

    private func setupScrollView(superView: UIView) {
        scrollView.delegate = self

        scrollView.frame = CGRect(x: 0, y: 0, width: superView.frame.width, height: superView.frame.height)
        scrollView.contentSize = CGSize(width: CGFloat(slides.count) * superView.frame.width, height: superView.frame.height)

        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: frame.width * CGFloat(i), y: 0, width: superView.frame.width, height: frame.height - pageControl.bounds.height)
            scrollView.addSubview(slides[i])
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(round(scrollView.contentOffset.x/frame.width))
        scrollView.contentOffset.y = 0.0
    }

    func didTapSlide(withImage img: UIImage?) {
        tapHandler?(img)
    }
}
