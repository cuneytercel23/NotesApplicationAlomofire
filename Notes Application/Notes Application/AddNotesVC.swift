//
//  AddNotesVC.swift
//  Notes Application
//
//  Created by Cüneyt Erçel on 5.09.2022.
//

import UIKit
import Alamofire

class AddNotesVC: UIViewController {
    @IBOutlet weak var lectureNameTF: UITextField!
    
    @IBOutlet weak var note2TF: UITextField!
    @IBOutlet weak var note1TF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func addNotes(ders_adi:String,not1:Int, not2:Int) { // initilazerın içini bu 3 veriyi girmemiz eklerken(post) web servisi bunları istiyor diye.
        
        let parameter : Parameters = ["ders_adi":ders_adi, "not1":not1, "not2":not2]
        
        AF.request("http://kasimadalan.pe.hu/notlar/insert_not.php", method: .post,parameters:parameter).response { response in
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        // Burada bizim vericeğimizi değerleri json verisine cevirerek, web servisine iletiyoruz ve tüm notlar kısmına eklediğimiz şey geliyor.
                        print(json) // bunu sadece ekleme işlemi yapınca web servisinde dediği gibi succes yazısını görmek için yapıyorum.
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
                
            }
                 
            
        }
        
    }
    
    /* yukarıdaki post işleminden sonra burası.
     bana dedim, name firstnote ve secondnote değişkenlerine textfielddan aldığım şeyleri buraya önce ata dedim. sonra millet mal gibi not kısmına 10 b falan yazmasın diye not kısımları için : n1 ve n2 yaptım ve eğer note 1 ve not 2 yi integer türünden gönderiyolarsa addNotesa ekle dedim ve zaten viewcontroller kısmında reload olduğu için geri döndüğümde kayıtlı olmus olucak.
     yani üstte ve burda webservisine eklemiş oldum ve getallnotes ile birlikte de reloadlayınca anasayfada oldu gösterilecek.
     */
    
   
    @IBAction func addButtonClicked(_ sender: UIButton) {
        
        if let name = lectureNameTF.text, let firstnote = note1TF.text,let secondnote = note2TF.text {
            
            if let n1 = Int(firstnote), let n2 = Int(secondnote) {
                
               addNotes(ders_adi: name, not1: n1, not2: n2)
                
            }
            
        }
        
    }
    
    
    
}
