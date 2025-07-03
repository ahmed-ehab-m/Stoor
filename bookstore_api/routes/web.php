<?php

use Illuminate\Support\Facades\Route;


// use App\Http\Controllers\Api\BookController;
// use App\Http\Controllers\Api\AuthorController;
// use App\Http\Controllers\Api\CategoryController;
// use App\Http\Controllers\HomeController;

// Route::get('/books', [BookController::class, 'index']);

// Route::get('/books/{id}', [BookController::class, 'show'])->name('books.show');

Route::get('/', function () {
    return view('welcome');
});
