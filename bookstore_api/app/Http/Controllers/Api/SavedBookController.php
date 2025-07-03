<?php

namespace App\Http\Controllers\Api;

use App\Models\SavedBook;
use App\Models\Book;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\BookResource;
use Illuminate\Support\Facades\Auth;

class SavedBookController extends Controller
{
    public function index()
    {
        $user = Auth::user();
        $savedBooks = SavedBook::where('user_id', $user->id)
            ->with(['book.author', 'book.category'])
            ->get()
            ->pluck('book');

        return BookResource::collection($savedBooks);
    }

    public function store(Request $request, $book_id)
    {
        $user = Auth::user();
        $book = Book::findOrFail($book_id);

        $savedBook = SavedBook::firstOrCreate([
            'user_id' => $user->id,
            'book_id' => $book->id,
        ]);

        return response()->json(['message' => 'Book added to saved books.', 'book' => new BookResource($book)]);
    }

    public function destroy($book_id)
    {
        $user = Auth::user();
        $savedBook = SavedBook::where('user_id', $user->id)
            ->where('book_id', $book_id)
            ->firstOrFail();

        $savedBook->delete();

        return response()->json(['message' => 'Book removed from saved books.']);
    }
}