//
//  StorageManager.swift
//  RealmApp
//
//  Created by Александра Лесовская on 25.04.2022.
//

import Foundation
import RealmSwift

class StorageManager {
    
    // MARK: - Static Properties
    static let shared = StorageManager()
    
    // MARK: - Public Properties
    let realm = try! Realm()
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - Actions For TaskList
    func save(_ taskLists: [TaskList]) {
        write {
            realm.add(taskLists)
        }
    }
    
    func save(_ taskList: TaskList) {
        write {
            realm.add(taskList)
        }
    }
    
    func delete(_ taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
        }
    }
    
    func edit(_ taskList: TaskList, newValue: String) {
        write {
            taskList.name = newValue
        }
    }

    func done(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
        }
    }

    // MARK: - Actions For Task
    func saveTask(_ task: Task, to taskList: TaskList) {
        write {
            taskList.tasks.append(task)
        }
    }
    
    func deleteTask(_ task: Task) {
        write {
            realm.delete(task)
            
        }
    }
    
    func editTask(task: Task, newValue: String, newNote: String) {
        write {
            task.name = newValue
            task.note = newNote
        }
    }

    func doneTask(_ task: Task) {
        write {
            task.isComplete = !task.isComplete
        }
    }
    
    // MARK: - Private Methods
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
}
