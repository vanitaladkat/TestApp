//
//  CircularCollectionViewController.swift
//  TestApp
//
//  Created by Vanita on 12/26/17.
//  Copyright © 2017 Tixdo. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController {
    
    override func loadView() {
        
        view = UIView()
        view.frame = UIScreen.main.bounds
        view.backgroundColor = UIColor.white
        
        addButton()
    }
    
    func addButton() {
        let button = UIButton()
        button.frame = CGRect(x: 16, y: 36, width: view.bounds.width - 32, height: 48)
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 36).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    @objc func buttonAction() {
        // ...
        
        let student = Student()
        student.name = "Vanita"
        student.id = 47
        student.address = "Pune"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        AppDelegate.saveContext()
    }
}

class AnotherClassTest: MyTestClass {
    override func myOpenFUnc() {
        
    }
    
    override func myFunc() {
        
    }
    
    override func myPublicFunc() {
        
    }
}

class CustomView: UIStackView {
    
    private lazy var panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(CustomView.singleFingerSwipe))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeProperties()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initializeProperties()
    }
    
    static var cnt: Int = 0
    @IBAction
    private func singleFingerSwipe(_ sender: UIPanGestureRecognizer) {
        print("Panning...", CustomView.cnt)
        CustomView.cnt += 1
    }
    
    private func initializeProperties() {
//        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(CustomView.singleFingerSwipe))

        addGestureRecognizer(panRecognizer)
        
        for _ in 1...3 {
            let imageView = UIImageView(image: UIImage(named: "0"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
//            imageView.isUserInteractionEnabled = true
            
            addArrangedSubview(imageView)
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        }
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

extension CircularCollectionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

class CircularCollectionViewController: UIViewController {

    @IBOutlet weak var aCollectionView: UICollectionView!
    
    var dataArray: [UIColor] = [.red, .blue, .cyan, .green]
    var prevOffset: CGPoint? = CGPoint.zero
    var cardWidth = UIScreen.main.bounds.size.width - 20
    var trackedOffset = CGPoint.zero
    var val = 0
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var checkPanGesture: UIView!
    
    @IBOutlet weak var lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.singleFingerSwipe))
        checkPanGesture.addGestureRecognizer(panRecognizer)

        
        
        let str = "https://xxx.xxxxx.com/CRM/feedback#/1715171559ae979371687#/10306".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
        let url1 = URL(string: str!)

        // Do any additional setup after loading the view.
        
        let tm = MyTime(seconds: 60)
        print(tm.minutes)
        print(tm.hours)
        tm.days = 1
        print(tm.seconds)
        
        let url = "https://static.pexels.com/photos/36753/flower-purple-lical-blosso.jpg"
        myImageView.downloadedFrom(url: URL(string: url)!)
        
        print(UIColor.red)
        print(UIColor.green)
        UIColor.swizzleDesription()
        print("\nswizzled\n")
        print(UIColor.red)
        print(UIColor.red)
        UIColor.swizzleDesription()
        print("\nTrying to swizzle again\n")
        print(UIColor.red)
        print(UIColor.red)
        
        let a: Int = 9
        let b: Double = 3
        print(myGenericFunc(a: a, b: b))
        
        let myClass: MyTestClass = MyTestChildClass()
        myClass.myFunc()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
        let scrollview = UIScrollView()
//        scrollview.frame = view.bounds
        self.view.addSubview(scrollview)
        var contentWidth: CGFloat = 0
        for image in 0...2 {
            let imageToDisplay = UIImage(named: "\(image).png")
            let imageView = UIImageView(image: imageToDisplay)
            imageView.backgroundColor = .gray
            let xCordinate = view.frame.midX + view.frame.width * CGFloat(image)
            contentWidth += view.frame.width
            scrollview.addSubview(imageView)
            imageView.frame = CGRect(x: xCordinate - 50, y: (view.frame.height / 2)-50, width: 100, height: 100)
        }
        scrollview.contentSize = CGSize(width: contentWidth, height: view.frame.height)
        
        
        
        let stringText = "And this has been the greatest archeaological discovery of last decade of CHile!"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.hyphenationFactor = 0.1
        paragraphStyle.allowsDefaultTighteningForTruncation = true
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributedString = NSMutableAttributedString(string: stringText, attributes:
            [NSAttributedStringKey.paragraphStyle: paragraphStyle,
             NSAttributedStringKey.baselineOffset: NSNumber(value: 0),NSAttributedStringKey.kern: 0.5])
        
        lbl.attributedText = attributedString
        
        self.fieldEmptyError(value: true, textField: UITextField(), placeHolder: "UserName")
    }
    
    func fieldEmptyError(value: Bool, textField:UITextField, placeHolder: String) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var aTextView: UITextView!
    
    
    
    
    @IBAction func checkPanGestureBtnAction(_ sender: UIButton) {
        
        
        //cjhange frame
        checkPanGesture.frame = self.view.bounds
    }
    
    @objc func singleFingerSwipe(_ sender: UIPanGestureRecognizer) {
        print("Panning...")
    }
    
    @IBAction func resignTextView(_ sender: Any) {
        aTextView.resignFirstResponder()
        
        
//        let viewController = InventoryViewController()
//        self.view.addSubview(viewController.view)
        
//        navigationController?.pushViewController(viewController, animated: false)
    }
    
    @objc func keyboardShown() {
        self.view.frame = CGRect(x: 0, y: -100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    @objc func keyBoardHidden() {
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func myGenericFunc<T>(a: T, b: T) -> T {
        print(a)
        print(b)
        return a
    }
    
}

extension CircularCollectionViewController: UITextViewDelegate {
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.backgroundColor = .cyan
        keyboardToolBar.sizeToFit()
        let btn1 = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneBtnAction))
        keyboardToolBar.items = [btn1]
        textView.inputAccessoryView = keyboardToolBar
        return true
    }
    
    @objc func doneBtnAction(sender: UIBarButtonItem) {
        aTextView.resignFirstResponder()
        self.view.endEditing(true)
    }
}

extension CircularCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var myProp: Int {
        get {
            return self.val
        }
        set {
            val = newValue/20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath)
        (cell.viewWithTag(10) as? UILabel)?.backgroundColor = dataArray[indexPath.item]
        cell.backgroundColor = dataArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cardWidth, height: 100)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scrollViewDidScroll")
        let currentOffsetX = scrollView.contentOffset.x
        if (prevOffset?.x)! < currentOffsetX  {
            //scroll to forward
            if (currentOffsetX) >= cardWidth {
                dataArray.append(dataArray.remove(at: 0))
                print(dataArray)
                aCollectionView.reloadData()
                trackedOffset = scrollView.contentOffset
                aCollectionView.contentOffset = CGPoint.zero
            }
        }
        else if (prevOffset?.x)! > currentOffsetX {
            if ((trackedOffset.x) - currentOffsetX) >= cardWidth && currentOffsetX != 0 {
                print("else dataarray chnaged")
                dataArray.insert((dataArray.removeLast()), at: 0)
                print(dataArray)
                aCollectionView.reloadData()
                trackedOffset = scrollView.contentOffset
                aCollectionView.contentOffset = CGPoint.zero
            } 
        }
        
        prevOffset = scrollView.contentOffset

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollViewWillEndDragging")
    }
}



public extension UIColor {
    @objc func colorDescription() -> String {
        return "Printing rainbow colours."
    }
    private static let swizzleDesriptionImplementation: Void = {
        let instance: UIColor = UIColor.red
        let aClass: AnyClass! = object_getClass(instance)
        let originalMethod = class_getInstanceMethod(aClass, #selector(description))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(colorDescription))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            // switch implementation..
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()
    public static func swizzleDesription() {
        _ = self.swizzleDesriptionImplementation
    }
}


/*
 
 
 Dil Diyan Gallan Lyrics
 
 Kacchi doriyon, doriyon, doriyon se
 Mainu tu baandh le
 Pakki yaariyon, yaariyon, yaariyon mein
 Honde na faasley
 
 Eh naraazgi kaagzi saari teri
 Mere sohneya sunn le meri
 Dil diyan gallan
 Karaange naal naal beh ke
 Akh naale akh nu milaa ke
 
 Dil diyan gallan haaye…
 Karaange roz roz beh ke
 Sacchiyan mohabbataan nibha ke
 
 Sataaye mainu kyun
 Dikhaaye mainu kyun
 Aiven jhuthi mutthi russ ke rusaake
 Dil diyan gallan haaye
 Karaange naal naal beh ke
 Akh naale akh nu mila ke
 
 Tenu lakhan ton chhupa ke rakhaan
 Akkhaan te sajaa ke tu ae meri wafaa
 Rakh apna bana ke
 Main tere layi aan
 Tere layi aan yaaran
 Naa paavin kade dooriyan (x2)
 
 Main jeena haan tera…
 Main jeena haan tera
 Tu jeena hai mera
 Dass lena ki nakhra dikha ke
 
 Dil diyan gallan
 Karaange naal naal beh ke
 Akh naale akh nu mila ke
 
 Dil diyan gallan…
 
 Raatan kaaliyan, kaaliyan, kaaliyan ne
 Mere dil saanwle
 Mere haaniyan, haaniyan, haaniyan je
 Lagge tu na gale
 
 Mera aasmaan mausamaan di na sune
 Koi khwaab na poora bane
 Dil diyan gallan
 Karange naal naal beh ke
 Akh naale akh nu mila ke
 
 Pataa hai mainu kyun chupa ke dekhe tu
 Mere naam se naam mila ke
 Dil diyan gallan
 Karange naal naal beh ke
 Akh naale akh nu mila ke
 
 Dil diyan gallan…
 
 
 
 */
