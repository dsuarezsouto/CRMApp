//
//  FechasViewController.swift
//  PruebaPractica4
//
//  Created by Alberto Jimenez on 23/11/17.
//  Copyright © 2017 Alberto Jimenez. All rights reserved.
//

import UIKit

class FechasViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*DatePickers*/
    @IBOutlet weak var inicioFecha: UIDatePicker!
    @IBOutlet weak var finFecha: UIDatePicker!
    
    /*Botones*/
    @IBAction func favoritosBoton(_ sender: UIButton) {
        if (finFecha.date <= inicioFecha.date){
            let alertErrorFechas = UIAlertController(title: "¡Error!", message: "¡No puedes escoger una fecha de inicio posterior a la final!", preferredStyle: .alert)
            alertErrorFechas.addAction(UIAlertAction(title: "OK", style: .default, handler: {(aa :UIAlertAction) in
                print("Se pulso OK")
            }))
            
            present(alertErrorFechas, animated: true)
        }
    }
    @IBAction func usuarioVisitasButton(_ sender: UIButton) {
        if (finFecha.date <= inicioFecha.date){
            let alertErrorFechas = UIAlertController(title: "¡Error!", message: "¡No puedes escoger una fecha de inicio posterior a la final!", preferredStyle: .alert)
            alertErrorFechas.addAction(UIAlertAction(title: "OK", style: .default, handler: {(aa :UIAlertAction) in
                print("Se pulso OK")
            }))
            
            present(alertErrorFechas, animated: true)
        }
    }
    @IBAction func visitasButton(_ sender: UIButton) {
        
        if (finFecha.date <= inicioFecha.date){
            let alertErrorFechas = UIAlertController(title: "¡Error!", message: "¡No puedes escoger una fecha de inicio posterior a la final!", preferredStyle: .alert)
            alertErrorFechas.addAction(UIAlertAction(title: "OK", style: .default, handler: {(aa :UIAlertAction) in
                print("Se pulso OK")
            }))
            
            present(alertErrorFechas, animated: true)
        }
    }
    
    /*Inlcuimos este metodo para evitar que el segue se realice antes que la alertview*/
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Go Visitas"{
            if (finFecha.date <= inicioFecha.date){
                return false
            }
            else{
                return true
            }
        }
        if identifier == "Go Acceso Token"{
            if (finFecha.date <= inicioFecha.date){
                return false
            }
            else{
                return true
            }
        }
        return true
    }

    /*Segues hacia la vista correspondiente enviando la url necesaria para cada caso*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        // Get the new view controller using segue.destinationViewController.
        
        
            if segue.identifier == "Go Visitas" {
            if let wvc = segue.destination as? VisitsTableViewController {
                navigationController?.navigationItem.largeTitleDisplayMode = .never

                wvc.title = "Visitas de todos los usuarios"
                let fechaInicio = formateaFecha(inicioFecha.date)
                let fechaFin = formateaFecha(finFecha.date)
                wvc.strurl = "https://dcrmt.herokuapp.com/api/visits/flattened?token=\(wvc.token)&dateafter=\(fechaInicio)&datebefore=\(fechaFin)"
            }
        }
            if segue.identifier == "Go Favoritos" {
            if let wvc = segue.destination as? VisitsTableViewController {
                navigationController?.navigationItem.largeTitleDisplayMode = .never

                wvc.title = "Visitas favoritas"
                let fechaInicio = formateaFecha(inicioFecha.date)
                let fechaFin = formateaFecha(finFecha.date)
                wvc.strurl = "https://dcrmt.herokuapp.com/api/visits/flattened?token=\(wvc.token)&dateafter=\(fechaInicio)&datebefore=\(fechaFin)&favourites=1"
            }
        }
        if segue.identifier == "Go Acceso Token" {
            if let wvc = segue.destination as? VisitsTableViewController {
                wvc.title = "Visitas del usuario"
                let fechaInicio = formateaFecha(inicioFecha.date)
                let fechaFin = formateaFecha(finFecha.date)
                wvc.strurl = "https://dcrmt.herokuapp.com/api/users/tokenOwner/visits/flattened?token=\(wvc.token)&dateafter=\(fechaInicio)&datebefore=\(fechaFin)"
            }
        }
        
        // Pass the selected object to the new view controller.
    }
    
    /*Funcion privada para formatear las fechas*/
    private func formateaFecha(_ date: Date)-> String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: (date))
    }
    

}
