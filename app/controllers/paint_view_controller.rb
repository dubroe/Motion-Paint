class PaintViewController < UIViewController
  BUTTON_VIEW_HEIGHT = 100
  PAINT_VIEW_WIDTH = 500
  PAINT_VIEW_HEIGHT = 200
  TOTAL_HEIGHT = 600
  
  def viewDidLoad
    super
    self.title = "Paint"
    @paintView = PaintView.alloc.initWithFrame(CGRectMake((self.view.bounds.size.width - PAINT_VIEW_WIDTH) / 2, (TOTAL_HEIGHT - BUTTON_VIEW_HEIGHT - PAINT_VIEW_HEIGHT) / 2, PAINT_VIEW_WIDTH, PAINT_VIEW_HEIGHT))
    view.addSubview @paintView 
    
    @saveButton = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @saveButton.setTitle('Save', forState: UIControlStateNormal)
    @saveButton.sizeToFit
    @saveButton.center = CGPointMake(self.view.bounds.size.width * 3 / 4, TOTAL_HEIGHT - BUTTON_VIEW_HEIGHT / 2)
    view.addSubview(@saveButton)
    @saveButton.when(UIControlEventTouchUpInside) do
      saveImage
      self.navigationController.viewControllers[0].image = @paintView.captureImage
      self.navigationController.popToRootViewControllerAnimated true
    end
    
    @clearButton = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @clearButton.setTitle('Clear', forState: UIControlStateNormal)
    @clearButton.sizeToFit
    @clearButton.center = CGPointMake(self.view.bounds.size.width / 4, TOTAL_HEIGHT - BUTTON_VIEW_HEIGHT / 2)
    view.addSubview(@clearButton)
    @clearButton.when(UIControlEventTouchUpInside) do
      @paintView.eraseContent
    end
  end

  def motionEnded(motion, withEvent:event)
    self.view.eraseContent if motion == UIEventSubtypeMotionShake
  end
  
  def saveImage
    image = @paintView.captureImage
    
    fileManager = NSFileManager.defaultManager
    myImageData = UIImagePNGRepresentation(image)
    fileManager.createFileAtPath "/Users/elandubrofsky/Desktop/myimage.png", contents:myImageData, attributes:nil
  end
end
