<?php

namespace App\Http\Controllers\Api;

use App\Models\Favorite;
use App\Models\Book;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\BookResource;
use Illuminate\Support\Facades\Auth;

class FavoriteController extends Controller
{
   public function index(Request $request)
{
    $request->validate([
        'user_id' => 'required|string',
    ]);

    $userId = $request->user_id;

    $favorites = Favorite::where('user_id', $userId)
        ->with(['book.author', 'book.category'])
        ->get()
        ->pluck('book');

    return BookResource::collection($favorites);
}

 public function store(Request $request, $book_id)
{
    try {
        $request->validate([
            'user_id' => 'required|string', // شيلنا شرط وجوده في جدول users
        ]);

        $userId = $request->user_id;
        $book = Book::findOrFail($book_id);

        $favorite = Favorite::firstOrCreate([
            'user_id' => $userId,
            'book_id' => $book->id,
        ]);

        return response()->json([
            'message' => 'Book added to favorites.',
            'book' => new BookResource($book)
        ]);
    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
}


public function destroy(Request $request, $book_id)
{
    $request->validate([

        'user_id' => 'required|string',
    ]);

    $userId = $request->user_id;

    $favorite = Favorite::where('user_id', $userId)
        ->where('book_id', $book_id)
        ->firstOrFail();

    $favorite->delete();

    return response()->json(['message' => 'Book removed from favorites.']);
}

}