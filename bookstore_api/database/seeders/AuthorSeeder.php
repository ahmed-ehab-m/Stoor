<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Author;

class AuthorSeeder extends Seeder
{
    public function run()
    {
        // Arabic authors
        Author::create(['name' => 'نجيب محفوظ', 'bio' => 'أديب مصري، حاصل على جائزة نوبل']);
        Author::create(['name' => 'أحمد خالد توفيق', 'bio' => 'كاتب مصري متخصص في أدب الخيال العلمي']);
        Author::create(['name' => 'خولة حمدي', 'bio' => 'كاتبة تونسية']);
        Author::create(['name' => 'احمد يوسف', 'bio' => 'كاتب مصري']);
        Author::create(['name' => 'سامي سبيح', 'bio' => 'كاتب مصري']);
        Author::create(['name' => 'احمد سلامة', 'bio' => 'كاتب مصري']);

        // English authors
        Author::create(['name' => 'George Orwell', 'bio' => 'English writer, famous for his works on social justice and totalitarianism']);
        Author::create(['name' => 'J.K. Rowling', 'bio' => 'British author best known for the Harry Potter series']);
        Author::create(['name' => 'Harper Lee', 'bio' => 'American author known for "To Kill a Mockingbird"']);
        Author::create(['name' => 'J.R.R. Tolkien', 'bio' => 'English writer, known for "The Hobbit" and "The Lord of the Rings"']);
        Author::create(['name' => 'F. Scott Fitzgerald', 'bio' => 'American novelist known for "The Great Gatsby"']);
        Author::create(['name' => 'Jane Austen', 'bio' => 'English author known for her six major novels, including "Pride and Prejudice"']);
        Author::create(['name' => 'Mark Twain', 'bio' => 'American author of novels like "The Adventures of Tom Sawyer"']);
        Author::create(['name' => 'Charles Dickens', 'bio' => 'English writer and social critic, famous for novels like "A Tale of Two Cities"']);
        Author::create(['name' => 'Leo Tolstoy', 'bio' => 'Russian author best known for "War and Peace"']);
        Author::create(['name' => 'Stephen King', 'bio' => 'American author specializing in horror, fantasy, and suspense']);
    }
}
