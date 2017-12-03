//
//  VisitsTableViewController.swift
//  PruebaPractica4
//
//  Created by Alberto Jimenez on 21/11/17.
//  Copyright © 2017 Alberto Jimenez. All rights reserved.
//

import UIKit

//typealias visit = [String:Any]


class VisitsTableViewController: UITableViewController {
   
    //Estructura para el Json
    struct Visita : Codable {
        let plannedFor : String
        let notes : String
        struct customer : Codable {
            let name : String
        }
        let Customer : customer
        struct salesman : Codable {
            struct photo : Codable {
                let url : String
                
            }
            let Photo : photo
        }
        let Salesman : salesman
    }
    
    //Token del usuario
    let token = "ff19916267f2fa6bafb4"
    //Variable para guardar todas las visitas
    var visits = [Visita]()
    //Sesion para poder descargar el data del url
    var session = URLSession.shared
    //Cache para guardar las imagenes
    var imgcache = [String : UIImage]()
    //Url distinta para cada Json
    var strurl = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadVisits()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return visits.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Visit Cell", for: indexPath) as! VisitasViewCell

            // Configure the cell...
            
            let visit = visits[indexPath.row]
            cell.nombreLabel?.text = "" //nombre
            cell.fechaLabel?.text = "" //fecha
        

            /*Añadimos el nombre*/
           cell.nombreLabel?.text = visit.Customer.name
           cell.nombreLabel.textColor = UIColor.darkText
            
            /*Añadimos la fecha*/
            let date = visit.plannedFor
            let df = ISO8601DateFormatter()
            df.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            if let d = df.date(from: date){
                 let str3 = ISO8601DateFormatter.string(from: d, timeZone: .current, formatOptions: [.withFullDate])
                cell.fechaLabel?.text = "Fecha: " + str3
                cell.fechaLabel?.textColor = UIColor.lightGray

            }
            
             /*Añadimos las notas*/
            cell.notasLabel?.text = visit.notes
            
             /*Añadimos las fotos*/
            let strImg = visit.Salesman.Photo.url
            if let img = imgcache[strImg]{
                cell.iconoView?.image = img
            }else{
                updatePhoto(strImg, for: indexPath)
            }
            
 
            return cell
        }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            visits.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Go Visitas" {
            if let wvc = segue.source as? FechasViewController {
                fechaInicio = wvc.inicioFecha.date
                fechaFin = wvc.finFecha.date
            }
        }
    }
 */
    
    /*Funcion privada para descargar el Json especifico*/
    private func downloadVisits(){
        print(strurl)
        if let url = URL(string : strurl) {
            let t = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print ("ERROR TIPO 1")
                    return
                }
                if (response as! HTTPURLResponse).statusCode != 200{
                    print ("hola")
                    return
                }
                if let visits = (try? JSONDecoder().decode([Visita].self, from: data!)){
                    
                    DispatchQueue.main.async {
                        self.visits = visits
                        self.tableView.reloadData()
                    }
                }
            }
            t.resume()
        }
    }
    
    /*Funcion privada para descargar la imagen y meterla en el cache*/
    private func updatePhoto(_ strurl: String, for indexPath: IndexPath) {
        DispatchQueue.global().async {
            if let url = URL(string: strurl),
                let data = try? Data(contentsOf: url),
                let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imgcache[strurl] = img
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                }
                
            }
        }
    }
    
    
    /*Funcion privada para formatear las fechas*/
    private func formateaFecha(_ date: Date)-> String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: (date))
    }

}





/* Codigo antiguo
 
 //        if let customer = visit["Customer"] as? [String:Any],
 //            let name = customer["name"] as? String {
 //            cell.nombreLabel?.text = name
 //            cell.nombreLabel.textColor = UIColor.darkText
 //        }
 
 //        if let plannedFor = visit["plannedFor"] as? String {
 //
 //
 //            let df = ISO8601DateFormatter()
 //
 //            df.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
 //
 //            if let d = df.date(from: plannedFor){
 //                let str3 = ISO8601DateFormatter.string(from: d, timeZone: .current, formatOptions: [.withFullDate])
 //                cell.fechaLabel?.text = "Fecha: " + str3
 //                cell.fechaLabel?.textColor = UIColor.lightGray
 //            }
 //        }
 
 //        if let salesman = visit["Salesman"] as? [String:Any],
 //        let photo = salesman["Photo"] as? [String:Any],
 //            let strurl = photo["url"] as? String {
 //
 //            if let img = imgcache[strurl] {
 //                cell.iconoView?.image = img
 //            }else{
 //                updatePhoto(strurl, for: indexPath)
 //
 //            }
 //        }
 
 //        if let nota = visit["notes"] as? String {
 //
 //                cell.notasLabel?.text = nota
 //        }
 //
 //let url = URL(string: strurl){
 */
