<?php

namespace App\Http\Controllers\Api;

use App\Models\Book;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\BookResource;
use Illuminate\Support\Facades\Storage;

class BookController extends Controller
{
    public function index()
    {
        $books = Book::with(['author', 'category'])->get();
        // return view('books.index', compact('books'));
        return BookResource::collection($books);
    }
    public function highestRated()
    {
        $books = Book::with(['author', 'category'])
            ->orderBy('rating', 'desc')
            ->take(5)
            ->get();
        return BookResource::collection($books);
    }
    public function lowestRated()
    {
        $books = Book::with(['author', 'category'])
            ->orderBy('rating', 'asc')
            ->take(5)
            ->get();
        return BookResource::collection($books);
    }

    public function show($id)
    {
        $book = Book::with(['author', 'category'])->findOrFail($id);
        // return view('books.show', compact('book'));
        return new BookResource($book);
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|numeric',
            'rating' => 'nullable|numeric|min:0|max:5',
            'category_id' => 'required|exists:categories,id',
            'author_id' => 'required|exists:authors,id',
            'image' => 'nullable|image|mimes:jpg,jpeg,png'
        ]);

        $book = new Book($request->only(['title', 'description', 'price', 'rating', 'category_id', 'author_id']));

        if ($request->hasFile('image')) {
            $book->image = $request->file('image')->store('books', 'public');
        }

        $book->save();

        return new BookResource($book);
    }

    

    public function update(Request $request, $id)
    {
        $book = Book::findOrFail($id);

        $request->validate([
            'title' => 'sometimes|string|max:255',
            'description' => 'nullable|string',
            'price' => 'sometimes|numeric',
            'rating' => 'nullable|numeric|min:0|max:5',
            'category_id' => 'sometimes|exists:categories,id',
            'author_id' => 'sometimes|exists:authors,id',
            'image' => 'nullable|image|mimes:jpg,jpeg,png'
        ]);

        $book->fill($request->only(['title', 'description', 'price', 'rating', 'category_id', 'author_id']));

        if ($request->hasFile('image')) {
            // Delete old image if exists
            if ($book->image) {
                Storage::disk('public')->delete($book->image);
            }
            $book->image = $request->file('image')->store('books', 'public');
        }

        $book->save();

        return new BookResource($book);
    }

    public function destroy($id)
    {
        $book = Book::findOrFail($id);
        if ($book->image) {
            Storage::disk('public')->delete($book->image);
        }
        $book->delete();
        return response()->json(['message' => 'Book deleted successfully.']);
    }
}
