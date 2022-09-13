//
//  ViewController.swift
//  Notes Application
//
//  Created by Cüneyt Erçel on 5.09.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var notesList = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        /* boş kalmasın diye örnek
        let n1 = Notes(not_id: 1, ders_adi: "Tarih", note1: 50, note2: 69)
        notesList.append(n1) */
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getAllNotes() // bunu buraya yazdık cünkü sürekli güncellenmesini istiyoruz en başta değil.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNoteDetails" {
            let indeks = sender as? Int
            let noteDetailsVC = segue.destination as! NoteDetailsVC
            
            noteDetailsVC.note = notesList[indeks!]
        }
    }
    

    func getAllNotes() {
        AF.request("http://kasimadalan.pe.hu/notlar/tum_notlar.php", method: .get).response { response in
            
            if let data = response.data {
                
                do {
                    let cevap = try JSONDecoder().decode(notesResponse.self, from: data)
                    
                    if let arrivingNotList = cevap.notlar { // notlar dediğimiz webservis ile aynı olan tek türkçe laf zaten.
                        
                        self.notesList = arrivingNotList 
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData() // arka planda tableviewu arayüzünü güncelledik.
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let note = notesList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCustomCell") as! NotesViewCell
        
        cell.lectureNameLabel.text = note.ders_adi
        cell.firstNoteLabel.text = String(note.note1!)
        cell.secondNoteLabel.text = String(note.note2!)
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toNoteDetails", sender: indexPath.row)
    }
    
}

