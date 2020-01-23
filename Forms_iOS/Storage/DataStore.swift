//
//  DataStore.swift
//  Forms_iOS
//
//  Created by Soumya on 23/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import RealmSwift

class DataStore {

    static let shared = DataStore()

    func saveDataToStore(model: FormModel, completion: @escaping () -> Void) {
        do {
            let realm = try Realm()
            try? realm.write {
                realm.add(model)
                completion()
            }
        } catch {
            print("Error in Saving \(error.localizedDescription)")
        }
    }

    func retriveDataFromStore(completion: @escaping (_ model: Results<FormModel>) -> Void) {
        do {
            let realm = try Realm()
            let formsArray = realm.objects(FormModel.self)
            completion(formsArray)
        } catch {
            print("Error in Saving \(error.localizedDescription)")
        }
    }

    func deleteDataFromStore(model: FormModel,completion: @escaping () -> Void) {
        do {
            let realm = try Realm()
            try? realm.write {
                realm.delete(model)
                completion()
            }
        } catch {
            print("Error in Saving \(error.localizedDescription)")
        }
    }

}
