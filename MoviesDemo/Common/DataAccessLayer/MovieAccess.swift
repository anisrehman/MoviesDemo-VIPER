//
//  CountryAccess.swift
//  MoviesDemo
//
//  Created by Anis Rehman on 13/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

// Performs db operations on MovieEntity
class MovieAccess {
    // It removes all Movies that were previously stored and add the Movies to db from Movie model. 
    static func resetMovies (_ movies: [Movie], category: Category) {
        deleteAllMovies(category: category)
        movies.forEach { (movie) in
            self.addMovie(movie, in: category)
        }
    }
    static func addMovie(_ movie: Movie, in category: Category) {
    
        let managedContext = DatabaseManager.shared().persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntity.movieEntity.rawValue, in: managedContext)!
        
        let movieEntity = NSManagedObject(entity: entity,
                                     insertInto: managedContext) as! MovieEntity
        movieEntity.id = movie.id
        movieEntity.popularity = movie.popularity
        movieEntity.voteCount = movie.voteCount
        movieEntity.video = movie.video
        movieEntity.posterPath = movie.posterPath
        movieEntity.adult = movie.adult
        movieEntity.backdropPath = movie.backdropPath
        movieEntity.originalLanguage = movie.originalLanguage
        movieEntity.originalTitle = movie.originalTitle
        movieEntity.title = movie.title
        movieEntity.voteAverage = movie.voteAverage
        movieEntity.overview = movie.overview
        movieEntity.releaseDate = movie.releaseDate
        movieEntity.category = Int32(category.rawValue)
        
        do {
            try managedContext.save()
            debugPrint("Movie saved")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Load all movies from db
    static func allMovies(category: Category) -> [MovieEntity] {
        let managedContext = DatabaseManager.shared().persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataEntity.movieEntity.rawValue)
        fetchRequest.predicate = NSPredicate(format: "category == %d", category.rawValue)
        do {
            let allMovies = try managedContext.fetch(fetchRequest) as! [MovieEntity]
            return allMovies
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    //Query the specific movies from db that contains the string in title
    static func searchMovies(text: String, category: Category) -> [MovieEntity] {
        let managedContext = DatabaseManager.shared().persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataEntity.movieEntity.rawValue)
        fetchRequest.predicate = NSPredicate(format: "title contains[cd] %@ AND category == %d", text, category.rawValue)
        do {
            let allMovies = try managedContext.fetch(fetchRequest) as! [MovieEntity]
            return allMovies
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func deleteAllMovies(category: Category) {
        let managedContext = DatabaseManager.shared().persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataEntity.movieEntity.rawValue)
        fetchRequest.predicate = NSPredicate(format: "category == %d", category.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
}
