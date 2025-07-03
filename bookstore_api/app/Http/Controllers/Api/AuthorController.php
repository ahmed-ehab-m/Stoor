<?php

namespace App\Http\Controllers\Api;
use App\Models\Author;


use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class AuthorController extends Controller
{
    //
    public function index()
    {
        $authors = Author::all();
        return response()->json($authors);
    }
}
