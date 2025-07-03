<?php
namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Book;
use App\Models\Author;
use App\Models\Category;

class BookSeeder extends Seeder
{
    public function run()
    {
        // Existing Books (Arabic)

        // Author and Category associations for Arabic books
        $author1 = Author::where('name', 'نجيب محفوظ')->first();
        $category1 = Category::where('name', 'رواية')->first();

        Book::create([
            'title' => 'قصر الشوق',
            'description' => 'رواية ضمن الثلاثية التي كتبها نجيب محفوظ.',
            'price' => 150,
            'rating' => 4.8,
            'author_id' => $author1->id,
            'category_id' => $category1->id,
            'image' => 'books/b (2).jpeg'
        ]);

        $author2 = Author::where('name', 'أحمد خالد توفيق')->first();
        $category2 = Category::where('name', 'خيال علمي')->first();

        Book::create([
            'title' => 'يوتوبيا',
            'description' => 'خيال علمي سوداوي يعكس انهيار المجتمع.',
            'price' => 120,
            'rating' => 4.5,
            'author_id' => $author2->id,
            'category_id' => $category2->id,
            'image' => 'books/yotopia.jpeg'
        ]);

        $author3 = Author::where('name', 'خولة حمدي')->first();
        $category3 = Category::where('name', 'رومانسية')->first();

        Book::create([
            'title' => 'في قلبي أنثى عبرية',
            'description' => 'رواية رومانسية تدور حول قصة حب في ظل تعقيدات الحياة.',
            'price' => 100,
            'rating' => 4.6,
            'author_id' => $author3->id,
            'category_id' => $category3->id,
            'image' => 'books/في قلبي أنثى عبرية.jpeg'
        ]);


        $author4 = Author::where('name', 'أحمد خالد توفيق')->first();
        $category4 = Category::where('name', 'خيال علمي')->first();

        Book::create([
            'title' => 'الكوميديا',
            'description' => 'خيال علمي سوداوي يعكس انهيار المجتمع.',
            'price' => 120,
            'rating' => 4.5,
            'author_id' => $author4->id,
            'category_id' => $category4->id,
            'image' => 'books/komedia.jpeg'
        ]);

        // New English Books

        $author5 = Author::where('name', 'George Orwell')->first();
        $category5 = Category::where('name', 'Dystopian')->first();

        Book::create([
            'title' => '1984',
            'description' => 'A dystopian novel about totalitarianism and surveillance.',
            'price' => 200,
            'rating' => 4.9,
            'author_id' => $author5->id,
            'category_id' => $category5->id,
            'image' => 'books/1984.jpeg'
        ]);

        $author6 = Author::where('name', 'J.K. Rowling')->first();
        $category6 = Category::where('name', 'Fantasy')->first();

        Book::create([
            'title' => 'Harry Potter and the Sorcerer\'s Stone',
            'description' => 'The first book in the Harry Potter series, about a young wizard.',
            'price' => 250,
            'rating' => 4.8,
            'author_id' => $author6->id,
            'category_id' => $category6->id,
            'image' => 'books/hp1.jpeg'
        ]);

        $author7 = Author::where('name', 'Harper Lee')->first();
        $category7 = Category::where('name', 'Classic')->first();

        Book::create([
            'title' => 'To Kill a Mockingbird',
            'description' => 'A novel about racial injustice and childhood innocence.',
            'price' => 180,
            'rating' => 4.7,
            'author_id' => $author7->id,
            'category_id' => $category7->id,
            'image' => 'books/mockbird.jpeg'
        ]);

        $author8 = Author::where('name', 'J.R.R. Tolkien')->first();
        $category8 = Category::where('name', 'Fantasy')->first();

        Book::create([
            'title' => 'The Hobbit',
            'description' => 'A fantasy adventure novel, prequel to the Lord of the Rings.',
            'price' => 220,
            'rating' => 4.9,
            'author_id' => $author8->id,
            'category_id' => $category8->id,
            'image' => 'books/hobbit.jpeg'
        ]);

        $author9 = Author::where('name', 'F. Scott Fitzgerald')->first();
        $category9 = Category::where('name', 'Classic')->first();

        Book::create([
            'title' => 'The Great Gatsby',
            'description' => 'A story of love and tragedy during the Roaring Twenties.',
            'price' => 190,
            'rating' => 4.5,
            'author_id' => $author9->id,
            'category_id' => $category9->id,
            'image' => 'books/gatsby.jpeg'
        ]);

        $author10 = Author::where('name', 'Jane Austen')->first();
        $category10 = Category::where('name', 'Romance')->first();

        Book::create([
            'title' => 'Pride and Prejudice',
            'description' => 'A classic novel of love, family, and manners.',
            'price' => 150,
            'rating' => 4.7,
            'author_id' => $author10->id,
            'category_id' => $category10->id,
            'image' => 'books/pride.jpeg'
        ]);

        $author11 = Author::where('name', 'Mark Twain')->first();
        $category11 = Category::where('name', 'Adventure')->first();

        Book::create([
            'title' => 'The Adventures of Huckleberry Finn',
            'description' => 'A novel about a young boy\'s adventures along the Mississippi River.',
            'price' => 160,
            'rating' => 4.6,
            'author_id' => $author11->id,
            'category_id' => $category11->id,
            'image' => 'books/huckleberry.jpeg'
        ]);

        $author12 = Author::where('name', 'Charles Dickens')->first();
        $category12 = Category::where('name', 'Historical Fiction')->first();

        Book::create([
            'title' => 'A Tale of Two Cities',
            'description' => 'A historical novel set during the French Revolution.',
            'price' => 170,
            'rating' => 4.7,
            'author_id' => $author12->id,
            'category_id' => $category12->id,
            'image' => 'books/twocities.jpeg'
        ]);

        $author13 = Author::where('name', 'Leo Tolstoy')->first();
        $category13 = Category::where('name', 'Historical Fiction')->first();

        Book::create([
            'title' => 'War and Peace',
            'description' => 'A historical novel about the Napoleonic Wars in Russia.',
            'price' => 300,
            'rating' => 4.9,
            'author_id' => $author13->id,
            'category_id' => $category13->id,
            'image' => 'books/warandpeace.jpeg'
        ]);

        $author14 = Author::where('name', 'Stephen King')->first();
        $category14 = Category::where('name', 'Horror')->first();

        Book::create([
            'title' => 'The Shining',
            'description' => 'A horror novel about a family haunted by supernatural forces.',
            'price' => 250,
            'rating' => 4.8,
            'author_id' => $author14->id,
            'category_id' => $category14->id,
            'image' => 'books/shining.jpeg'
        ]);
        

    }
}
