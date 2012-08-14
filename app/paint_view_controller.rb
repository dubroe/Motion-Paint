class PaintViewController < UIViewController
  BUTTON_VIEW_HEIGHT = 100
  def loadView
    super
    @paintView = PaintView.alloc.initWithFrame(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - BUTTON_VIEW_HEIGHT))
    view.addSubview @paintView 
    
    @saveButton = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @saveButton.setTitle('Save', forState: UIControlStateNormal)
    @saveButton.sizeToFit
    @saveButton.center = CGPointMake(self.view.bounds.size.width * 3 / 4, self.view.bounds.size.height - BUTTON_VIEW_HEIGHT / 2)
    view.addSubview(@saveButton)
    @saveButton.when(UIControlEventTouchUpInside) do
      saveImage
    end
    
    @clearButton = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @clearButton.setTitle('Clear', forState: UIControlStateNormal)
    @clearButton.sizeToFit
    @clearButton.center = CGPointMake(self.view.bounds.size.width / 4, self.view.bounds.size.height - BUTTON_VIEW_HEIGHT / 2)
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
    
    puts image.getBase64
  end
end
