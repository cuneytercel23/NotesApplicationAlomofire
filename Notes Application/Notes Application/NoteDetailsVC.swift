//
//  NoteDetailsVC.swift
//  Notes Application
//
//  Created by Cüneyt Erçel on 5.09.2022.
//

import UIKit
import Alamofire

class NoteDetailsVC: UIViewController {

    @IBOutlet weak var detailsNote2TF: UITextField!
    @IBOutlet weak var detailsNote1TF: UITextField!
    @IBOutlet weak var detailsLectureNameTF: UITextField!
    
    var note : Notes? // buraya notları göndericez diye bunu yazdık
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let n = note { // en başta ilk gelen verileri verdik.
            detailsNote1TF.text = n.note1
            detailsLectureNameTF.text = n.ders_adi
            detailsNote2TF.text = n.note2
            
        }

    }
    
    @IBAction func deleteButtonClicked(_ sender: UIBarButtonItem) {
        if let n = note {
            if let nid = Int(n.not_id!){ // burada dönüşüm yapıyoruz.
                deleteNotes(ders_id: nid)
            }
        }
    }
    
    
    
   // alta update fonksiyonunu yaptık şimdi burayı yapıcaz. bu kısmı addnotesdan caldım saddece azcık ekleme yapıcam.
    @IBAction func updateButtonClicked(_ sender: UIButton) {
        
        if let n = note, let name = detailsLectureNameTF.text, let firstnote = detailsNote1TF.text,let secondnote = detailsNote2TF.text {
            
            if let n1 = Int(firstnote), let nid = Int(n.not_id!), let n2 = Int(secondnote) {
                
                updateNotes(ders_id: nid, ders_adi: name, not1: n1, not2: n2)
              
                
            }
            
        }
        
        
    
        
    }
    
}

func updateNotes(ders_id:Int,ders_adi:String,not1:Int, not2:Int) { // initilazerın içini bu 3 veriyi girmemiz eklerken(post) web servisi bunları istiyor diye.
    
    let parameter : Parameters = ["ders_id": ders_id,"ders_adi":ders_adi, "not1":not1, "not2":not2]
    
    AF.request("http://kasimadalan.pe.hu/notlar/update_not.php", method: .post,parameters:parameter).response { response in
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


func deleteNotes(ders_id:Int) { // initilazerın içini bu 3 veriyi girmemiz eklerken(post) web servisi bunları istiyor diye.
    
    let parameter : Parameters = ["ders_id":ders_id]
    
    AF.request("http://kasimadalan.pe.hu/notlar/delete_not.php", method: .post,parameters:parameter).response { response in
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

