class PaintView < UIView
  def initWithFrame(rect)
    if super
      @paths = []
    end
    self
  end

  def drawRect(rect)
    UIColor.whiteColor.set
    UIBezierPath.bezierPathWithRect(rect).fill
    @paths.each do |path, color|
      color.set
      path.stroke
    end
  end

  def touchesBegan(touches, withEvent:event)
    bp = UIBezierPath.alloc.init
    bp.lineWidth = 3.0
    @paths << [bp, UIColor.blackColor]
  end

  def touchesMoved(touches, withEvent:event)
    touch = event.touchesForView(self).anyObject
    point = touch.locationInView(self)
    if @previousPoint and !@paths.empty?
      bp = @paths.last.first
      bp.moveToPoint(@previousPoint)
      bp.addLineToPoint(point)
    end
    @previousPoint = point
    setNeedsDisplay
  end

  def touchesEnded(touches, withEvent:event)
    @previousPoint = nil
  end

  def eraseContent
    @paths.clear
    setNeedsDisplay
  end
  
  def captureImage
    UIGraphicsBeginImageContext(bounds.size)
    layer.renderInContext UIGraphicsGetCurrentContext()
    image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    image
  end
  
end
