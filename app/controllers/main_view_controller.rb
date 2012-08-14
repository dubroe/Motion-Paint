class MainViewController < UIViewController
  attr_accessor :image
  
  def viewDidLoad
    super
    self.title = "Main"
    view.backgroundColor = UIColor.whiteColor
    view.whenTapped do
      @paintViewController = PaintViewController.alloc.init
      self.navigationController.pushViewController(@paintViewController, animated: true)
    end
    @imageView = UIImageView.alloc.initWithFrame(view.bounds)
    view.addSubview(@imageView)
  end
  
  def viewDidAppear(animated)
    super(animated)
    if image
      @imageView.image = image
      puts image.getBase64
    end
  end
end