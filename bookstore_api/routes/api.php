<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\BookController;
use App\Http\Controllers\Api\AuthorController;
use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\FavoriteController;
use App\Http\Controllers\Api\SavedBookController;

Route::prefix('v1')->group(function () {
    Route::get('/test', function () {
    return response()->json(['msg' => 'API is working']);
    });

    // Book Routes
    Route::get('books', [BookController::class, 'index']);           // Get all books
    Route::get('books/highest-rated', [BookController::class, 'highestRated']); 
    Route::get('books/lowest-rated', [BookController::class, 'lowestRated']);
    Route::get('books/{id}', [BookController::class, 'show']);       // Get book details
    Route::post('books', [BookController::class, 'store']);          
    Route::put('books/{id}', [BookController::class, 'update']);     
    Route::delete('books/{id}', [BookController::class, 'destroy']); 

    // Author Routes
    Route::get('authors', [AuthorController::class, 'index']);       // Get all authors

    // Category Routes
    Route::get('categories', [CategoryController::class, 'index']);  // Get all categories

    // Favorite Routes (Protected by auth)
    // Route::middleware('auth:sanctum')->group(function () {
        Route::get('favorites', [FavoriteController::class, 'index']); // Get user's favorite books
        Route::post('favorites/{book_id}', [FavoriteController::class, 'store']); // Add book to favorites
        Route::delete('favorites/{book_id}', [FavoriteController::class, 'destroy']); // Remove book from favorites

        // Saved Book Routes
        Route::get('saved-books', [SavedBookController::class, 'index']); // Get user's saved books
        Route::post('saved-books/{book_id}', [SavedBookController::class, 'store']); // Add book to saved books
        Route::delete('saved-books/{book_id}', [SavedBookController::class, 'destroy']); // Remove book from saved books
    // });
});