import Foundation
import CoreData

public class CoreDataUserRepository: UserRepository {
    private let context: NSManagedObjectContext

    public init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }

    public func save(user: User) throws {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "CDUser", into: context)
        entity.setValue(user.id, forKey: "id")
        entity.setValue(user.email, forKey: "email")
        entity.setValue(user.password, forKey: "password")
        try context.save()
    }

    public func fetch(byEmail email: String) throws -> User? {
        let req = NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        req.predicate = NSPredicate(format: "email == %@", email)
        req.fetchLimit = 1
        let results = try context.fetch(req)
        guard let obj = results.first else { return nil }
        guard
            let id = obj.value(forKey: "id") as? UUID,
            let email = obj.value(forKey: "email") as? String,
            let password = obj.value(forKey: "password") as? String
        else { return nil }
        return User(id: id, email: email, password: password)
    }

    public func fetchAll() throws -> [User] {
        let req = NSFetchRequest<NSManagedObject>(entityName: "CDUser")
        let results = try context.fetch(req)
        return results.compactMap { obj in
            guard
                let id = obj.value(forKey: "id") as? UUID,
                let email = obj.value(forKey: "email") as? String,
                let password = obj.value(forKey: "password") as? String
            else { return nil }
            return User(id: id, email: email, password: password)
        }
    }
}
