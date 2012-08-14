class UIImage
  def getBase64
    UIImageJPEGRepresentation(self, 1.0).base64Encoding
  end
end