//
//  DataStore.swift
//  Forms_iOS
//
//  Created by Soumya on 23/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import RealmSwift

class DataStore {

    var updateUI: ((Results<FormModel>)-> Void)?

    func saveDataToStore(model: FormModel) {
        do {
            let realm = try Realm()
            try? realm.write {
                realm.add(model)
                self.retriveDataFromStore()
            }
        } catch {
            print("Error in Saving \(error.localizedDescription)")
        }
    }

    func retriveDataFromStore() {
        do {
            let realm = try Realm()
            let formsArray = realm.objects(FormModel.self)
            self.updateUI?(formsArray)
        } catch {
            print("Error in Saving \(error.localizedDescription)")
        }
    }

    func deleteDataFromStore(model: FormModel) {
        do {
            let realm = try Realm()
            try? realm.write {
                realm.delete(model)
                return self.retriveDataFromStore()
            }
        } catch {
            print("Error in Saving \(error.localizedDescription)")
        }
    }

}
