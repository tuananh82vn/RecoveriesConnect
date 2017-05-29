
class NormalPhoneEditor: TKDataFormEditor, UITextFieldDelegate {
    
    let textField = MyTextField2()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textField.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 31)
        textField.keyboardType = .phonePad
        textField.addTarget(self, action: #selector(MyPhoneEditor.notifyValueChange), for: .editingChanged)
        textField.delegate = self
        self.addSubview(textField)
        self.gridLayout.addDefinition(for: textField, atRow: 0, column: 2, rowSpan: 1, columnSpan: 1)
    }
    
    override init(property: TKEntityProperty) {
        super.init(property: property)
        self.setupEditor(property)
    }
    
    override init(property: TKEntityProperty, owner: TKDataForm) {
        super.init(property: property, owner: owner)
        self.setupEditor(property)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var isTextEditor: Bool {
        get {
            return true
        }
    }
    
    func setupEditor(_ property: TKEntityProperty) {
        self.textField.placeholder = self.property.hintText
        if property.valueCandidate != nil {
            self.textField.text = (property.valueCandidate as AnyObject).description
        }
        self.value = property.valueCandidate
    }
    
    override var editor: UIView {
        get {
            return textField
        }
    }
    
    override func updateControlValue() {
        textField.text = (self.description as AnyObject).description
    }
    
    override func update() {
        super.update()
        textField.isEnabled = self.enabled == false ? self.enabled : !self.property.readOnly
    }
    
    func notifyValueChange() {
        //self.formatText()
        self.value = textField.text
        self.owner.editorValueChanged(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //self.textField.text = ""
        self.owner.setEditorOnFocus(self)
        return true
    }
    
}

class MyTextField2: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}


