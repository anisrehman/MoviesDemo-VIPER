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

protocol MovieStoring {
    func resetMovies (_ movies: [Movie], category: Category)
    func addMovie(_ movie: Movie, in category: Category)
    func allMovies(category: Category) -> [MovieEntity]
    func searchMovies(text: String, category: Category) -> [MovieEntity]
    func deleteAllMovies(category: Category)
}

// Performs db operations on MovieEntity
class MovieRepository: MovieStoring {
    var context: NSManagedObjectContext;

    init() {
        context = DatabaseManager.shared().persistentContainer.viewContext
    }

    // It removes all Movies that were previously stored and add the Movies to db from Movie model. 
    func resetMovies (_ movies: [Movie], category: Category) {
        deleteAllMovies(category: category)
        movies.forEach { (movie) in
            self.addMovie(movie, in: category)
        }
    }

    func addMovie(_ movie: Movie, in category: Category) {

        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntity.movieEntity.rawValue, in: context)!
        
        let movieEntity = NSManagedObject(entity: entity,
                                     insertInto: context) as! MovieEntity
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
            try context.save()
            debugPrint("Movie saved")
        } catch let error as NSError {
            debugPrint("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Load all movies from db
    func allMovies(category: Category) -> [MovieEntity] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataEntity.movieEntity.rawValue)
        fetchRequest.predicate = NSPredicate(format: "category == %d", category.rawValue)
        do {
            let allMovies = try context.fetch(fetchRequest) as! [MovieEntity]
            return allMovies
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    //Query the specific movies from db that contains the string in title
    func searchMovies(text: String, category: Category) -> [MovieEntity] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataEntity.movieEntity.rawValue)
        fetchRequest.predicate = NSPredicate(format: "title contains[cd] %@ AND category == %d", text, category.rawValue)
        do {
            let allMovies = try context.fetch(fetchRequest) as! [MovieEntity]
            return allMovies
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func deleteAllMovies(category: Category) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataEntity.movieEntity.rawValue)
        fetchRequest.predicate = NSPredicate(format: "category == %d", category.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
