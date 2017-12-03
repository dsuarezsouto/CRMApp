//
//  UserViewController.swift
//  PruebaPractica4
//
//  Created by Alberto Jimenez on 22/11/17.
//  Copyright © 2017 Alberto Jimenez. All rights reserved.
//

import UIKit


class UserViewController: UITableViewController {
    
    
    /*Estructura para el Json*/
    struct Usuario : Codable {
        let login : String
        let fullname : String
        struct photo : Codable{
            let url : String
        }
        let Photo : photo
    }
    
    /*Token del usuario*/
    let token = "ff19916267f2fa6bafb4"
    /*Variable para guardar todos los usuarios*/
    var usuarios = [Usuario]()
    /*Sesion para descargar un data*/
    var session = URLSession.shared
    /*Cache para guardar la imagen con su respectivo url*/
    var imgcache = [String : UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadVisits()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return usuarios.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Visit Cell", for: indexPath) as! VisitasViewCell
        
        // Configure the cell...
        let usuarios = self.usuarios[indexPath.row]
        cell.nombreLabel?.text = "" //nombre
        cell.fechaLabel?.text = "" //fecha
        
        /*Añadimos el nombre*/
        cell.nombreLabel?.text = usuarios.fullname
        /*Añadimos el id*/
        cell.notasLabel?.text = usuarios.login
        
        /*Añadimos la foto*/
        let imgUrl = usuarios.Photo.url
        if let img = imgcache[imgUrl]{
            cell.iconoView.image = img
        }else{
            updatePhoto(imgUrl, for: indexPath)
        }
        return cell
    }
    
    /*Funcion privada para descargar las iamgenes e introducirlas en el cache segun su url*/
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
    
    /*Funcion privada para descargar las visitas*/
    private func downloadVisits(){
        
        let strurl = "https://dcrmt.herokuapp.com/api/users?token=\(token)"
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
                if let usuarios = (try? JSONDecoder().decode([Usuario].self, from: data!)){
                    DispatchQueue.main.async {
                        self.usuarios = usuarios
                        self.tableView.reloadData()
                    }
                    
                }
            }
            t.resume()
        }
    }
    
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
    

    
    
    
}

